import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/components/level_instance/hud/hovered_outline_hud_button.dart';
import 'package:maze_ball/components/level_instance/input_handler.dart';

class HudKeyboard extends PositionComponent
    with HasGameReference<MazeBallGame> {
  InputHandler inputHandler;

  HudKeyboard({super.position, required this.inputHandler});

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
      HoverOutlineHudButton(
        position: Vector2(0, 0),
        button: TextComponent(
          position: Vector2.zero(),
          text: '←',
          textRenderer: textRenderer,
        ),
        onPressed: () {
          inputHandler.handleKey(LogicalKeyboardKey.arrowLeft);
        },
      ),
    );

    await add(
      HoverOutlineHudButton(
        position: Vector2(8, 0),
        button: TextComponent(
          position: Vector2.zero(),
          text: '→',
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
