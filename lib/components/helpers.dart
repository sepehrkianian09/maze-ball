import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/level_instance.dart';

import 'helpers/text.dart';
import 'helpers/vector.dart';

class MazeBallHelpers extends PositionComponent {
  MazeBallHelpers(LevelInstance game) {
    // gravity helper
    add(
      VectorHelper(
        position: Vector2(32.5, 22.5),
        theVector: game.ball!.body.gravityOverride!,
        color: Colors.blueGrey,
        vectorName: "Gravity",
        textColor: Colors.black,
      ),
    );
    // velocity helper
    add(
      VectorHelper(
        position: Vector2(22.5, 22.5),
        theVector: game.ball!.body.linearVelocity,
        color: Colors.blueGrey,
        vectorName: "Velocity",
        textColor: Colors.black,
      ),
    );
    // score
    add(
      TextHelper(
        position: Vector2(12.5, 22),
        textShower: () => "Score: ${game.gameInstance.getScore()}",
        color: Colors.blueGrey,
      ),
    );
  }
}
