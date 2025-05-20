import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/components/maze_tile.dart';

enum MazeTileAngle {
  zero(0),
  perpendicular(pi / 2);

  final double value;
  const MazeTileAngle(this.value);
}

class Maze extends BodyComponent<MazeBallGame> {
  Maze() : super(bodyDef: BodyDef());

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
    final verticalItemsLength = horizontalItemsLength + 1;

    final gameRect = game.camera.visibleWorldRect;
    final gameWidth = gameRect.right - gameRect.left;
    final gameWidthStart = gameRect.left;
    final gameHeight = gameRect.top - gameRect.bottom;
    final gameHeightStart = gameRect.bottom;

    // add bound
    for (var i = 0; i <= horizontalItemsLength; i++) {
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
    for (var i = 0; i <= verticalItemsLength; i++) {
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
    for (var i = 0; i <= numberOfTiles; i++) {
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
