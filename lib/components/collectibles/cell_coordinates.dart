import 'package:flame/game.dart';

class CellCoordinates {
  final int x;
  final int y;

  CellCoordinates(this.x, this.y);
}

class CellCoordinatesConverter {
  final double _gameWidth;
  final double _gameHeight;

  final int _horizontalLength;
  final int _verticalLength;

  final double _gameWidthStart;
  final double _gameHeightStart;

  CellCoordinatesConverter({
    required double gameWidth,
    required double gameHeight,
    required int horizontalLength,
    required int verticalLength,
    required double gameWidthStart,
    required double gameHeightStart,
  }) : _gameHeightStart = gameHeightStart,
       _gameWidthStart = gameWidthStart,
       _verticalLength = verticalLength,
       _horizontalLength = horizontalLength,
       _gameHeight = gameHeight,
       _gameWidth = gameWidth;

  Vector2 convert(CellCoordinates coordinates) {
    return Vector2(
      _gameWidthStart + (coordinates.x + 0.5) * _gameWidth / _horizontalLength,
      _gameHeightStart + (coordinates.y + 0.5) * _gameHeight / _verticalLength,
    );
  }
}
