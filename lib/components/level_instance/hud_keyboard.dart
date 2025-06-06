import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/components/level_instance/helpers/text.dart';

class HudKeyboard extends PositionComponent
    with HasGameReference<MazeBallGame> {
  @override
  FutureOr<void> onLoad() async {
    final textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 5,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );

    await add(
      HudButtonComponent(
        position: Vector2(0, 0),
        button: TextComponent(
          position: Vector2.zero(),
          text: '←',
          textRenderer: textRenderer,
        ),
        onPressed: () {
          game.levelInstance?.rightKey();
        },
      ),
    );

    await add(
      HudButtonComponent(
        position: Vector2(5, 0),
        button: TextComponent(
          position: Vector2.zero(),
          text: '→',
          textRenderer: textRenderer,
        ),
        onPressed: () {
          game.levelInstance?.leftKey();
        },
      ),
    );

    return super.onLoad();
  }
}
