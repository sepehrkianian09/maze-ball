import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/level_instance/collectibles/ball.dart';
import 'package:maze_ball/components/level_instance/collectibles/cell_coordinates.dart';
import 'package:maze_ball/components/utils/body_component_with_user_data.dart';
import 'package:maze_ball/game.dart';

class Heart extends BodyComponentWithUserData<MazeBallGame>
    with ContactCallbacks {
  final CellCoordinates cellCoordinates;
  final double radius;

  Heart({
    required Vector2 position,
    required this.cellCoordinates,
    this.radius = 2.0,
  }) : super(
         bodyDef: BodyDef(
           type: BodyType.dynamic,
           gravityOverride: Vector2.zero(),
           position: position,
         ),
         fixtureDefs: [FixtureDef(CircleShape(radius: radius))],
         children: [
           CircleComponent(
             anchor: Anchor.center,
             radius: radius,
             paint: Paint()..color = Colors.redAccent,
           ),
         ],
       );

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      game.wonCurrentLevel();
    }
    super.beginContact(other, contact);
  }
}
