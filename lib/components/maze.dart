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

class Maze extends BodyComponent<MazeBallGame> with KeyboardHandler {
  Maze()
    : super(
        bodyDef: BodyDef(
          type: BodyType.static,
          gravityOverride: Vector2.zero(),
        ),
      );

  double _randomPosition(
    Random theRandom,
    double start,
    double length,
    int divisionLength,
  ) {
    return start + theRandom.nextInt(divisionLength) * length / divisionLength;
  }

  final tileSize = Vector2(10, 2);

  MazeTile _createMazeTile(
    double horizontalPosition,
    double verticalPosition,
    MazeTileAngle angle,
  ) {
    switch (angle) {
      case MazeTileAngle.zero:
        horizontalPosition += 5;
        break;
      case MazeTileAngle.perpendicular:
        verticalPosition += 5;
        break;
    }
    return MazeTile(
      position: Vector2(horizontalPosition, verticalPosition),
      size: tileSize,
      color: Colors.amber,
      angle: angle.value,
    );
  }

  Future<void> _buildMazeBound(
    int horizontalItemsLength,
    int verticalItemsLength,
  ) async {
    final gameRect = game.camera.visibleWorldRect;
    final gameWidth = gameRect.right - gameRect.left;
    final gameWidthStart = gameRect.left;
    final gameHeight = gameRect.bottom - gameRect.top;
    final gameHeightStart = gameRect.top;

    // add horizontal walls
    final widthSpace = gameWidth / horizontalItemsLength - tileSize.x;
    for (var i = 0; i < horizontalItemsLength; i++) {
      await add(
        _createMazeTile(
          widthSpace / 2 +
              gameWidthStart +
              i * gameWidth / horizontalItemsLength,
          gameHeightStart,
          MazeTileAngle.zero,
        ),
      );
      await add(
        _createMazeTile(
          widthSpace / 2 +
              gameWidthStart +
              i * gameWidth / horizontalItemsLength,
          gameHeightStart + gameHeight,
          MazeTileAngle.zero,
        ),
      );
    }

    // add vertical walls
    final heightSpace = gameHeight / verticalItemsLength - tileSize.x;
    for (var i = 0; i < verticalItemsLength; i++) {
      await add(
        _createMazeTile(
          gameWidthStart,
          heightSpace / 2 +
              gameHeightStart +
              i * gameHeight / verticalItemsLength,
          MazeTileAngle.perpendicular,
        ),
      );
      await add(
        _createMazeTile(
          gameWidthStart + gameWidth,
          heightSpace / 2 +
              gameHeightStart +
              i * gameHeight / verticalItemsLength,
          MazeTileAngle.perpendicular,
        ),
      );
    }
  }

  Future<void> _buildRandomTiles(
    int horizontalItemsLength,
    int verticalItemsLength,
    Random theRandom,
  ) async {
    final gameRect = game.camera.visibleWorldRect;
    final gameWidth = gameRect.right - gameRect.left;
    final gameWidthStart = gameRect.left;
    final gameHeight = gameRect.bottom - gameRect.top;
    final gameHeightStart = gameRect.top;

    randomAngle() =>
        MazeTileAngle.values[theRandom.nextInt(MazeTileAngle.values.length)];

    final maximumNumberOfTiles =
        (horizontalItemsLength - 1) * (verticalItemsLength) +
        (horizontalItemsLength) * (verticalItemsLength - 1);
    int numberOfTiles = theRandom.nextInt(maximumNumberOfTiles / 2 as int);
    print("number of random tiles: $numberOfTiles");
    final addedTileCoordinates = [];

    final widthSpace = gameWidth / horizontalItemsLength - tileSize.x;
    final heightSpace = gameHeight / verticalItemsLength - tileSize.x;
    var i = 0;
    while (i < numberOfTiles) {
      double tileHorizontalPosition = 0;
      double tileVerticalPosition = 0;

      final angle = randomAngle();
      if (angle == MazeTileAngle.zero) {
        tileHorizontalPosition =
            widthSpace / 2 +
            _randomPosition(
              theRandom,
              gameWidthStart,
              gameWidth,
              horizontalItemsLength,
            );
        tileVerticalPosition = _randomPosition(
          theRandom,
          gameHeightStart + gameHeight / verticalItemsLength,
          gameHeight - gameHeight / verticalItemsLength,
          verticalItemsLength - 1,
        );
      } else if (angle == MazeTileAngle.perpendicular) {
        tileHorizontalPosition = _randomPosition(
          theRandom,
          gameWidthStart + gameWidth / horizontalItemsLength,
          gameWidth - gameWidth / horizontalItemsLength,
          horizontalItemsLength - 1,
        );
        tileVerticalPosition =
            heightSpace / 2 +
            _randomPosition(
              theRandom,
              gameHeightStart,
              gameHeight,
              verticalItemsLength,
            );
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
        _createMazeTile(tileHorizontalPosition, tileVerticalPosition, angle),
      );
      i++;
    }
  }

  @override
  Future<void> onLoad() async {
    final horizontalItemsLength = 4;
    final verticalItemsLength = 4;

    await _buildMazeBound(horizontalItemsLength, verticalItemsLength);

    await _buildRandomTiles(
      horizontalItemsLength,
      verticalItemsLength,
      Random(),
    );

    return super.onLoad();
  }
}
