import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final double heartRadius = 2.0;

class Heart extends BodyComponent {
  Heart({required Vector2 position})
    : super(
        bodyDef: BodyDef(type: BodyType.static, position: position),
        fixtureDefs: [FixtureDef(CircleShape(radius: heartRadius))],
        children: [
          CircleComponent(
            anchor: Anchor.center,
            radius: heartRadius,
            paint: Paint()..color = Colors.redAccent,
          ),
        ],
      );
}
