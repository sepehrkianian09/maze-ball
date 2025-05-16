import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/components/maze_tile.dart';

class Maze extends BodyComponent<MazeBallGame> {
  Maze() : super(bodyDef: BodyDef());

  @override
  Future<void> onLoad() async {
    final gameRect = game.camera.visibleWorldRect;
    final gameWidth = gameRect.right - gameRect.left;
    for (var i = 0; i <= 4; i++) {
      final tileSize = Vector2(10, 2);
      await add(
        MazeTile(
          position: Vector2(
            gameRect.left + (i * gameWidth / 4),
            gameRect.bottom - 4,
          ),
          size: tileSize,
          color: Colors.amber,
          angle: pi / 2
        ),
      );
    }

    return super.onLoad();
  }
}
