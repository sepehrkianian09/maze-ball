import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'tile.dart';
import 'tile_coordinates.dart';

class MazeTileFactory {
  final double _gameWidth;
  final double _gameHeight;

  final int _horizontalLength;
  final int _verticalLength;

  final double _gameWidthStart;
  final double _gameHeightStart;

  MazeTileFactory({
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

  final _tileSize = Vector2(12, 2);

  Vector2 get tileSpace {
    return Vector2(
      _gameWidth / _horizontalLength - _tileSize.x,
      _gameHeight / _verticalLength - _tileSize.x,
    );
  }

  Vector2 _getPosition(MazeTileCoordinates coordinates) {
    switch (coordinates.angle) {
      case MazeTileAngle.zero:
        return Vector2(
          _gameWidthStart +
              coordinates.horizontalIndex * (_tileSize.x + tileSpace.x) +
              _tileSize.x / 2.0 +
              tileSpace.x / 2.0,
          _gameHeightStart +
              coordinates.verticalIndex * (_tileSize.x + tileSpace.y),
        );
      case MazeTileAngle.perpendicular:
        return Vector2(
          _gameWidthStart +
              coordinates.horizontalIndex * (_tileSize.x + tileSpace.x),
          _gameHeightStart +
              coordinates.verticalIndex * (_tileSize.x + tileSpace.y) +
              _tileSize.x / 2.0 +
              tileSpace.y / 2.0,
        );
    }
  }

  MazeTile createTile(MazeTileCoordinates coordinates) {
    return MazeTile(
      position: _getPosition(coordinates),
      size: _tileSize,
      color: Colors.amber,
      angle: coordinates.angle.value,
    );
  }
}