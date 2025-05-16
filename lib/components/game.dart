import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import 'background.dart';

class MazeBallGame extends Forge2DGame {
  MazeBallGame()
    : super(
        gravity: Vector2(0, 10),
        camera: CameraComponent.withFixedResolution(width: 800, height: 600),
      );

  @override
  FutureOr<void> onLoad() async {
    final backgroundImage = await images.load('colored_shroom.png');
    await world.add(Background(sprite: Sprite(backgroundImage)));

    return super.onLoad();
  }
}
