import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/ball.dart';
import 'package:maze_ball/components/body_component_with_user_data.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/pages/game.dart';

final double heartRadius = 2.0;

class Heart extends BodyComponentWithUserData<MazeBallGame>
    with ContactCallbacks {
  Heart({required Vector2 position})
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
      game.playState = PlayState.won;
    }
    super.beginContact(other, contact);
  }
}
