import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Ball extends BodyComponent {
  final double size;

  Ball({
    required Vector2 position,
    required this.size,
    required MaterialColor color,
  }) : super(
         bodyDef:
             BodyDef(
                 gravityOverride: Vector2(0, 10.0),
                 isAwake: true,
                 allowSleep: false,
               )
               ..position = position
               ..type = BodyType.dynamic,
         fixtureDefs: [
           FixtureDef(CircleShape(radius: size / 2), friction: 0.3),
         ],
         children: [
           CircleComponent(
             anchor: Anchor.center,
             radius: size / 2,
             paint: Paint()..color = color,
           ),
         ],
       );
}
