import 'package:flame/game.dart';

import '../tile/maze_dimensions.dart';

class CellCoordinates {
  final int x;
  final int y;

  CellCoordinates(this.x, this.y);
}

class CellCoordinatesConverter {
  final MazeDimensions mazeDimensions;

  CellCoordinatesConverter({required this.mazeDimensions});

  Vector2 convert(CellCoordinates coordinates) {
    return Vector2(
      mazeDimensions.gameWidthStart + (coordinates.x + 0.5) * mazeDimensions.gameWidth / mazeDimensions.horizontalLength,
      mazeDimensions.gameHeightStart + (coordinates.y + 0.5) * mazeDimensions.gameHeight / mazeDimensions.verticalLength,
    );
  }
}
