import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class MazeTile extends BodyComponent {
  final Vector2 size;

  MazeTile({
    required Vector2 position,
    required this.size,
    required MaterialColor color,
    double angle = 0,
  }) : super(
         bodyDef:
             BodyDef(angle: angle)
               ..position = position
               ..type = BodyType.static,
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
}
