import 'package:flame/components.dart';

class MazeDimensions {
  final double gameWidth;
  final double gameHeight;

  final int horizontalLength;
  final int verticalLength;

  final double gameWidthStart;
  final double gameHeightStart;

  MazeDimensions({
    required this.gameWidth,
    required this.gameHeight,
    required this.horizontalLength,
    required this.verticalLength,
    required this.gameWidthStart,
    required this.gameHeightStart,
  });

  final tileSize = Vector2(12, 2);

  Vector2 get tileSpace {
    return Vector2(
      gameWidth / horizontalLength - tileSize.x,
      gameHeight / verticalLength - tileSize.x,
    );
  }
}
