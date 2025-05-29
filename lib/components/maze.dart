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

  @override
  Future<void> onLoad() async {
    final horizontalItemsLength = 4;
    final verticalItemsLength = 4;

    final gameRect = game.camera.visibleWorldRect;
    final gameWidth = gameRect.right - gameRect.left;
    final gameWidthStart = gameRect.left;
    final gameHeight = gameRect.bottom - gameRect.top;
    final gameHeightStart = gameRect.top;

    // add bound
    for (var i = 0; i < horizontalItemsLength; i++) {
      await add(
        _createMazeTile(
          gameWidthStart + i * gameWidth / horizontalItemsLength,
          gameHeightStart,
          MazeTileAngle.zero,
        ),
      );
      await add(
        _createMazeTile(
          gameWidthStart + i * gameWidth / horizontalItemsLength,
          gameHeightStart + gameHeight,
          MazeTileAngle.zero,
        ),
      );
    }
    for (var i = 0; i < verticalItemsLength; i++) {
      await add(
        _createMazeTile(
          gameWidthStart,
          gameHeightStart + i * gameHeight / verticalItemsLength,
          MazeTileAngle.perpendicular,
        ),
      );
      await add(
        _createMazeTile(
          gameWidthStart + gameWidth,
          gameHeightStart + i * gameHeight / verticalItemsLength,
          MazeTileAngle.perpendicular,
        ),
      );
    }

    final theRandom = Random();

    randomAngle() =>
        MazeTileAngle.values[theRandom.nextInt(MazeTileAngle.values.length)];

    final maximumNumberOfTiles = verticalItemsLength * horizontalItemsLength;
    print("maximum $maximumNumberOfTiles");
    final numberOfTiles = theRandom.nextInt(maximumNumberOfTiles);
    for (var i = 0; i < numberOfTiles; i++) {
      final angle = randomAngle();
      final tileHorizontalPosition = _randomPosition(
        theRandom,
        gameWidthStart,
        gameWidth,
        horizontalItemsLength,
      );
      final tileVerticalPosition = _randomPosition(
        theRandom,
        gameHeightStart,
        gameHeight,
        verticalItemsLength,
      );
      await add(
        _createMazeTile(tileHorizontalPosition, tileVerticalPosition, angle),
      );
    }

    return super.onLoad();
  }
}
