import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:maze_ball/components/maze.dart';

import 'background.dart';
import 'ball.dart';
import 'maze/tile.dart';

class MazeBallGame extends Forge2DGame with KeyboardEvents {
  MazeBallGame()
    : super(
        gravity: Vector2(0, 10),
        camera: CameraComponent.withFixedResolution(width: 800, height: 600),
      );

  final _maze = Maze();
  final _ball = Ball(position: Vector2.zero(), size: 10, color: Colors.brown);

  @override
  FutureOr<void> onLoad() async {
    final backgroundImage = await images.load('background/colored_grass.png');
    await world.add(Background(sprite: Sprite(backgroundImage)));

    await world.add(_ball);

    await world.add(_maze);

    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;

    print("event pressed $event");

    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        _ball.body.gravityOverride?.rotate(pi / 2);
        _ball.body.linearVelocity.setZero();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        _ball.body.gravityOverride?.rotate(- pi / 2);
        _ball.body.linearVelocity.setZero();
      }

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
