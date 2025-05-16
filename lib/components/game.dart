import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

import 'background.dart';
import 'ball.dart';
import 'ground.dart';

class MazeBallGame extends Forge2DGame {
  MazeBallGame()
    : super(
        gravity: Vector2(0, 10),
        camera: CameraComponent.withFixedResolution(width: 800, height: 600),
      );

  @override
  FutureOr<void> onLoad() async {
    final backgroundImage = await images.load('background/colored_grass.png');
    await world.add(Background(sprite: Sprite(backgroundImage)));

    final gameRect = camera.visibleWorldRect;
    await world.add(
      Ground(
        position: Vector2(0, gameRect.bottom - 4),
        size: Vector2(10, 2),
        color: Colors.amber,
      ),
    );

    await world.add(
      Ball(position: Vector2.zero(), size: 10, color: Colors.brown),
    );

    return super.onLoad();
  }
}