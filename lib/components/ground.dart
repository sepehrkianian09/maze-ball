import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Ground extends BodyComponent {
  final Vector2 size;

  Ground({
    required Vector2 position,
    required this.size,
    required MaterialColor color,
  }) : super(
         bodyDef:
             BodyDef()
               ..position = position
               ..type = BodyType.static,
         fixtureDefs: [
           FixtureDef(
             PolygonShape()..setAsBoxXY(size.x / 2, size.y / 2),
             friction: 0.3,
           ),
         ],
         children: [
          RectangleComponent(anchor: Anchor.center, paint: Paint()..color = color, size: size)
         ]
       );
}
