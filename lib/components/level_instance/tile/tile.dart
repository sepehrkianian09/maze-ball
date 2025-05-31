import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/level_instance/collectibles/ball.dart';
import 'package:maze_ball/components/utils/body_component_with_user_data.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/pages/game.dart';

class MazeTile extends BodyComponentWithUserData<MazeBallGame>
    with ContactCallbacks {
  final Vector2 size;

  MazeTile({
    required Vector2 position,
    required this.size,
    required MaterialColor color,
    double angle = 0,
  }) : super(
         bodyDef: BodyDef(
           angle: angle,
           type: BodyType.static,
           gravityOverride: Vector2.zero(),
         )..position = position,
         fixtureDefs: [
           FixtureDef(
             PolygonShape()..setAsBoxXY(size.x / 2, size.y / 2),
             friction: 0.3,
           ),
         ],
         children: [
           RectangleComponent(
             anchor: Anchor.center,
             size: size,
             paintLayers: [
               Paint()
                 ..color = Colors.white70
                 ..strokeWidth = 1
                 ..style = PaintingStyle.stroke,
               Paint()
                 ..color = color
                 ..style = PaintingStyle.fill,
             ],
           ),
         ],
       );

  @override
  void beginContact(Object other, Contact contact) {
    if (other is Ball) {
      game.playState = PlayState.gameOver;
    }
    super.beginContact(other, contact);
  }
}
