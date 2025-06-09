import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maze_ball/components/utils/outlined_rectangle.dart';
import 'package:maze_ball/game.dart';
import 'package:maze_ball/components/level_instance/hud/hovered_outline_hud_button.dart';
import 'package:maze_ball/components/level_instance/input_handler.dart';

class HudKeyboard extends PositionComponent
    with HasGameReference<MazeBallGame> {
  InputHandler inputHandler;

  HudKeyboard({super.position, required this.inputHandler});

  @override
  FutureOr<void> onLoad() async {
    await add(
      OutlinedRectangleComponent(
        position: Vector2(-5.0, 0),
        size: Vector2(25, 13),
        strokeWidth: 0.5,
      ),
    );

    await add(
      TextComponent(
        position: Vector2(7.5, 1.0),
        text: "JoyStick",
        anchor: Anchor.topCenter,
        textRenderer: TextPaint(
          style: TextStyle(fontSize: 3.0, color: Colors.black),
        ),
      ),
    );

    final textRenderer = TextPaint(
      style: TextStyle(
        fontSize: 5,
        color: Colors.deepOrangeAccent,
        fontWeight: FontWeight.bold,
      ),
    );

    await add(
      HoverOutlineHudButton(
        position: Vector2(-3.0, 6.0),
        button: TextComponent(
          position: Vector2.zero(),
          text: '-90°',
          textRenderer: textRenderer,
        ),
        onPressed: () {
          inputHandler.handleKey(LogicalKeyboardKey.arrowLeft);
        },
      ),
    );

    await add(
      HoverOutlineHudButton(
        position: Vector2(8, 6.0),
        button: TextComponent(
          position: Vector2.zero(),
          text: '+90°',
          textRenderer: textRenderer,
        ),
        onPressed: () {
          inputHandler.handleKey(LogicalKeyboardKey.arrowRight);
        },
      ),
    );

    return super.onLoad();
  }
}
