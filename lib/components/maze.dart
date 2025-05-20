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

  @override
  Future<void> onLoad() async {
    final verticalItemsLength = 4;
    final horizontalItemsLength = 4;
    final maximumNumberOfTiles = verticalItemsLength * horizontalItemsLength;

    final gameRect = game.camera.visibleWorldRect;
    final gameWidth = gameRect.right - gameRect.left;
    final gameWidthStart = gameRect.left;
    final gameHeight = gameRect.top - gameRect.bottom;
    final gameHeightStart = gameRect.bottom;

    final tileSize = Vector2(10, 2);

    final theRandom = Random();

    randomAngle() =>
        MazeTileAngle.values[theRandom.nextInt(MazeTileAngle.values.length)];

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
        MazeTile(
          position: Vector2(
            tileHorizontalPosition +
                (angle == MazeTileAngle.perpendicular ? 0 : tileSize.x / 2),
            tileVerticalPosition - 4,
          ),
          size: tileSize,
          color: Colors.amber,
          angle: angle.value,
        ),
      );
    }

    return super.onLoad();
  }
}
