import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/game_components/level_instance.dart';

import 'helpers/text.dart';
import 'helpers/vector.dart';

class MazeBallHelpers extends PositionComponent {
  final LevelInstance levelInstance;

  MazeBallHelpers({required this.levelInstance, required super.position});

  @override
  FutureOr<void> onLoad() async {
    // ball gravity
    await add(
      VectorHelper(
        position: Vector2(25, 0),
        theVector: levelInstance.ball.body.gravityOverride!,
        color: Colors.blueGrey,
        vectorName: "Gravity",
        textColor: Colors.black,
      ),
    );

    // ball velocity
    await add(
      VectorHelper(
        position: Vector2(17, 0),
        theVector: levelInstance.ball.body.linearVelocity,
        color: Colors.blueGrey,
        vectorName: "Velocity",
        textColor: Colors.black87,
      ),
    );

    // level
    await add(
      TextHelper(
        position: Vector2(1, 0),
        textShower: () => "Level ${levelInstance.level}",
        color: Colors.purpleAccent,
        anchor: Anchor.centerLeft
      ),
    );
    // score
    await add(
      TextHelper(
        position: Vector2(1, 4),
        textShower: () => "Score: ${levelInstance.game.getScore()}",
        color: Colors.yellowAccent,
        anchor: Anchor.centerLeft,
      ),
    );

    return super.onLoad();
  }
}
