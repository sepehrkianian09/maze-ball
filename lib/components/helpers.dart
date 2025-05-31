import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/level_instance.dart';

import 'helpers/text.dart';
import 'helpers/vector.dart';

class MazeBallHelpers extends PositionComponent {
  final LevelInstance levelInstance;

  MazeBallHelpers({required this.levelInstance});

  @override
  FutureOr<void> onLoad() async {
    // gravity helper
    add(
      VectorHelper(
        position: Vector2(32.5, 22.5),
        theVector: levelInstance.ball!.body.gravityOverride!,
        color: Colors.blueGrey,
        vectorName: "Gravity",
        textColor: Colors.black,
      ),
    );
    // velocity helper
    add(
      VectorHelper(
        position: Vector2(22.5, 22.5),
        theVector: levelInstance.ball!.body.linearVelocity,
        color: Colors.blueGrey,
        vectorName: "Velocity",
        textColor: Colors.black,
      ),
    );
    // score
    add(
      TextHelper(
        position: Vector2(12.5, 22),
        textShower: () => "Score: ${levelInstance.game.getScore()}",
        color: Colors.blueGrey,
      ),
    );

    return super.onLoad();
  }
}
