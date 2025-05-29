import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/components/maze_tile.dart';

import 'ball.dart';

enum MazeTileAngle {
  zero(0),
  perpendicular(pi / 2);

  final double value;
  const MazeTileAngle(this.value);
}

int horizontalItemsLength = 4;
int verticalItemsLength = 4;

class MazeTileFactory {
  final double _gameWidth;
  final double _gameHeight;

  final int _horizontalLength;
  final int _verticalLength;

  final double _gameWidthStart;
  final double _gameHeightStart;

  MazeTileFactory({
    required double gameWidth,
    required double gameHeight,
    required int horizontalLength,
    required int verticalLength,
    required double gameWidthStart,
    required double gameHeightStart,
  }) : _gameHeightStart = gameHeightStart,
       _gameWidthStart = gameWidthStart,
       _verticalLength = verticalLength,
       _horizontalLength = horizontalLength,
       _gameHeight = gameHeight,
       _gameWidth = gameWidth;

  final _tileSize = Vector2(12, 2);

  Vector2 get tileSpace {
    return Vector2(
      _gameWidth / _horizontalLength - _tileSize.x,
      _gameHeight / _verticalLength - _tileSize.x,
    );
  }

  MazeTile createTile(int i, int j, MazeTileAngle angle) {
    double horizontalPosition = 0.0;
    double verticalPosition = 0.0;

    switch (angle) {
      case MazeTileAngle.zero:
        horizontalPosition =
            _gameWidthStart +
            i * (_tileSize.x + tileSpace.x) +
            _tileSize.x / 2.0 +
            tileSpace.x / 2.0;
        verticalPosition = _gameHeightStart + j * (_tileSize.x + tileSpace.y);
        break;
      case MazeTileAngle.perpendicular:
        horizontalPosition = _gameWidthStart + i * (_tileSize.x + tileSpace.x);
        verticalPosition =
            _gameHeightStart +
            j * (_tileSize.x + tileSpace.y) +
            _tileSize.x / 2.0 +
            tileSpace.y / 2.0;
        break;
    }

    return MazeTile(
      position: Vector2(horizontalPosition, verticalPosition),
      size: _tileSize,
      color: Colors.amber,
      angle: angle.value,
    );
  }
}

class Maze extends BodyComponent<MazeBallGame> with KeyboardHandler {
  MazeTileFactory get _mazeTileFactory {
    final gameRect = game.camera.visibleWorldRect;
    final gameWidth = gameRect.right - gameRect.left;
    final gameWidthStart = gameRect.left;
    final gameHeight = gameRect.bottom - gameRect.top;
    final gameHeightStart = gameRect.top;

    return MazeTileFactory(
      gameWidth: gameWidth,
      gameHeight: gameHeight,
      horizontalLength: 4,
      verticalLength: 4,
      gameWidthStart: gameWidthStart,
      gameHeightStart: gameHeightStart,
    );
  }

  Maze()
    : super(
        bodyDef: BodyDef(
          type: BodyType.static,
          gravityOverride: Vector2.zero(),
        ),
      );

  Future<void> _buildMazeBound() async {
    // add horizontal walls
    for (var i = 0; i < horizontalItemsLength; i++) {
      await add(_mazeTileFactory.createTile(i, 0, MazeTileAngle.zero));
      await add(
        _mazeTileFactory.createTile(i, verticalItemsLength, MazeTileAngle.zero),
      );
    }

    // add vertical walls
    for (var j = 0; j < verticalItemsLength; j++) {
      await add(_mazeTileFactory.createTile(0, j, MazeTileAngle.perpendicular));
      await add(
        _mazeTileFactory.createTile(
          horizontalItemsLength,
          j,
          MazeTileAngle.perpendicular,
        ),
      );
    }
  }

  Future<void> _buildRandomTiles(Random theRandom) async {
    randomAngle() =>
        MazeTileAngle.values[theRandom.nextInt(MazeTileAngle.values.length)];

    final maximumNumberOfTiles =
        (horizontalItemsLength - 1) * (verticalItemsLength) +
        (horizontalItemsLength) * (verticalItemsLength - 1);
    int numberOfTiles = theRandom.nextInt(maximumNumberOfTiles / 2 as int);
    print("number of random tiles: $numberOfTiles");
    final addedTileCoordinates = [];

    var i = 0;
    while (i < numberOfTiles) {
      final angle = randomAngle();

      int tileHorizontalPosition = 0;
      int tileVerticalPosition = 0;
      if (angle == MazeTileAngle.zero) {
        tileHorizontalPosition = theRandom.nextInt(horizontalItemsLength);
        tileVerticalPosition = 1 + theRandom.nextInt(verticalItemsLength - 1);
      } else if (angle == MazeTileAngle.perpendicular) {
        tileHorizontalPosition =
            1 + theRandom.nextInt(horizontalItemsLength - 1);
        tileVerticalPosition = theRandom.nextInt(verticalItemsLength);
      }
      final tileCoordinates = (
        angle,
        tileHorizontalPosition,
        tileVerticalPosition,
      );
      print("tile coordinates: $tileCoordinates");
      if (addedTileCoordinates.contains(tileCoordinates)) {
        continue;
      }
      addedTileCoordinates.add(tileCoordinates);
      print("added tile coordinates: $tileCoordinates");
      await add(
        _mazeTileFactory.createTile(
          tileHorizontalPosition,
          tileVerticalPosition,
          angle,
        ),
      );
      i++;
    }
  }

  @override
  Future<void> onLoad() async {
    await _buildMazeBound();
    await _buildRandomTiles(Random());

    return super.onLoad();
  }
}
