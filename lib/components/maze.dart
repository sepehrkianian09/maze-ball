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

class MazeTileCoordinates {
  final int horizontalIndex;
  final int verticalIndex;
  final MazeTileAngle angle;

  MazeTileCoordinates({
    required this.horizontalIndex,
    required this.verticalIndex,
    required this.angle,
  });

  factory MazeTileCoordinates.randomInternal(
    Random theRandom,
    int horizontalItemsLength,
    int verticalItemsLength,
  ) {
    randomAngle() =>
        MazeTileAngle.values[theRandom.nextInt(MazeTileAngle.values.length)];
    final angle = randomAngle();

    switch (angle) {
      case MazeTileAngle.zero:
        return MazeTileCoordinates(
          horizontalIndex: theRandom.nextInt(horizontalItemsLength),
          verticalIndex: 1 + theRandom.nextInt(verticalItemsLength - 1),
          angle: angle,
        );
      case MazeTileAngle.perpendicular:
        return MazeTileCoordinates(
          horizontalIndex: 1 + theRandom.nextInt(horizontalItemsLength - 1),
          verticalIndex: theRandom.nextInt(verticalItemsLength),
          angle: angle,
        );
    }
  }
}

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

  Vector2 _getPosition(MazeTileCoordinates coordinates) {
    switch (coordinates.angle) {
      case MazeTileAngle.zero:
        return Vector2(
          _gameWidthStart +
              coordinates.horizontalIndex * (_tileSize.x + tileSpace.x) +
              _tileSize.x / 2.0 +
              tileSpace.x / 2.0,
          _gameHeightStart +
              coordinates.verticalIndex * (_tileSize.x + tileSpace.y),
        );
      case MazeTileAngle.perpendicular:
        return Vector2(
          _gameWidthStart +
              coordinates.horizontalIndex * (_tileSize.x + tileSpace.x),
          _gameHeightStart +
              coordinates.verticalIndex * (_tileSize.x + tileSpace.y) +
              _tileSize.x / 2.0 +
              tileSpace.y / 2.0,
        );
    }
  }

  MazeTile createTile(MazeTileCoordinates coordinates) {
    return MazeTile(
      position: _getPosition(coordinates),
      size: _tileSize,
      color: Colors.amber,
      angle: coordinates.angle.value,
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
      await add(
        _mazeTileFactory.createTile(
          MazeTileCoordinates(
            horizontalIndex: i,
            verticalIndex: 0,
            angle: MazeTileAngle.zero,
          ),
        ),
      );
      await add(
        _mazeTileFactory.createTile(
          MazeTileCoordinates(
            horizontalIndex: i,
            verticalIndex: verticalItemsLength,
            angle: MazeTileAngle.zero,
          ),
        ),
      );
    }

    // add vertical walls
    for (var j = 0; j < verticalItemsLength; j++) {
      await add(
        _mazeTileFactory.createTile(
          MazeTileCoordinates(
            horizontalIndex: 0,
            verticalIndex: j,
            angle: MazeTileAngle.perpendicular,
          ),
        ),
      );
      await add(
        _mazeTileFactory.createTile(
          MazeTileCoordinates(
            horizontalIndex: horizontalItemsLength,
            verticalIndex: j,
            angle: MazeTileAngle.perpendicular,
          ),
        ),
      );
    }
  }

  Future<void> _buildRandomTiles(Random theRandom) async {
    final maximumNumberOfTiles =
        (horizontalItemsLength - 1) * (verticalItemsLength) +
        (horizontalItemsLength) * (verticalItemsLength - 1);
    int numberOfTiles = theRandom.nextInt(maximumNumberOfTiles / 2 as int);
    print("number of random tiles: $numberOfTiles");
    final addedTileCoordinates = [];

    var i = 0;
    while (i < numberOfTiles) {
      final tileCoordinates = MazeTileCoordinates.randomInternal(
        theRandom,
        horizontalItemsLength,
        verticalItemsLength,
      );
      print("tile coordinates: $tileCoordinates");
      if (addedTileCoordinates.contains(tileCoordinates)) {
        continue;
      }
      addedTileCoordinates.add(tileCoordinates);
      print("added tile coordinates: $tileCoordinates");
      await add(_mazeTileFactory.createTile(tileCoordinates));
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
