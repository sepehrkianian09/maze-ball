import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/body_component_with_user_data.dart';

final double ballRadius = 2.5;

class Ball extends BodyComponentWithUserData {
  Ball({required Vector2 position, required int level})
    : super(
        bodyDef:
            BodyDef(
                type: BodyType.dynamic,
                gravityOverride: Vector2(0, 5 * level + 5),
                isAwake: true,
                allowSleep: false,
                fixedRotation: true,
              )
              ..position = position,
        fixtureDefs: [
          FixtureDef(CircleShape(radius: ballRadius), friction: 0.3),
        ],
        children: [
          CircleComponent(
            anchor: Anchor.center,
            radius: ballRadius,
            paint: Paint()..color = Colors.lightBlueAccent,
          ),
        ],
      );
}
