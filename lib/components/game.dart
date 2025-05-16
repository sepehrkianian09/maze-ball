import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class MazeBallGame extends Forge2DGame {
  MazeBallGame()
    : super(
        gravity: Vector2(0, 10),
        camera: CameraComponent.withFixedResolution(width: 800, height: 600),
      );
}
