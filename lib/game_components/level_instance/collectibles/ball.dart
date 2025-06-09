import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/game_components/level_instance/collectibles/cell_coordinates.dart';
import 'package:maze_ball/game_components/utils/body_component_with_user_data.dart';

class Ball extends BodyComponentWithUserData {
  final CellCoordinates cellCoordinates;

  final double radius;

  Ball({
    required this.cellCoordinates,
    required Vector2 position,
    required int level,
    required this.radius,
  }) : super(
         bodyDef: BodyDef(
           type: BodyType.dynamic,
           gravityOverride: Vector2(0, 5 * level + 5),
           isAwake: true,
           allowSleep: false,
           fixedRotation: true,
         )..position = position,
         fixtureDefs: [FixtureDef(CircleShape(radius: radius), friction: 0.3)],
         children: [
           CircleComponent(
             anchor: Anchor.center,
             radius: radius,
             paint: Paint()..color = Colors.lightBlueAccent,
           ),
         ],
       );

  void rotateRight() {
    body.gravityOverride?.rotate(pi / 2);
    body.linearVelocity.setZero();
  }

  void rotateLeft() {
    body.gravityOverride?.rotate(-pi / 2);
    body.linearVelocity.setZero();
  }
}
