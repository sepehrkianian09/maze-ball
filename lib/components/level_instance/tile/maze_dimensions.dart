import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class MazeDimensions {
  final int horizontalLength;
  final int verticalLength;


  late double gameWidth;
  late double gameWidthStart;

  late double gameHeight;
  late double gameHeightStart;

  MazeDimensions({
    required Forge2DGame game,
    required this.horizontalLength,
    required this.verticalLength,
  }) {
    final gameRect = game.camera.visibleWorldRect;
    gameWidth = gameRect.right - gameRect.left;
    gameWidthStart = gameRect.left;
    gameHeight = gameRect.bottom - gameRect.top;
    gameHeightStart = gameRect.top;
  }

  final tileSize = Vector2(12, 2);

  Vector2 get tileSpace {
    return Vector2(
      gameWidth / horizontalLength - tileSize.x,
      gameHeight / verticalLength - tileSize.x,
    );
  }
}
