import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/level_instance/collectibles/ball.dart';
import 'package:maze_ball/components/level_instance/collectibles/cell_coordinates.dart';
import 'package:maze_ball/components/utils/body_component_with_user_data.dart';
import 'package:maze_ball/components/game.dart';

final double heartRadius = 2.0;

class Heart extends BodyComponentWithUserData<MazeBallGame>
    with ContactCallbacks {
  final CellCoordinates cellCoordinates;

  Heart({required Vector2 position, required this.cellCoordinates})
    : super(
        bodyDef: BodyDef(
          type: BodyType.dynamic,
          gravityOverride: Vector2.zero(),
          position: position,
        ),
        fixtureDefs: [FixtureDef(CircleShape(radius: heartRadius))],
        children: [
          CircleComponent(
            anchor: Anchor.center,
            radius: heartRadius,
            paint: Paint()..color = Colors.redAccent,
          ),
        ],
      );

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      game.goToNextLevel();
    }
    super.beginContact(other, contact);
  }
}
