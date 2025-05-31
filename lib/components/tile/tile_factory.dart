import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/tile/maze_dimensions.dart';

import 'tile.dart';
import 'tile_coordinates.dart';

class MazeTileFactory {
  final MazeDimensions mazeDimensions;

  MazeTileFactory({required this.mazeDimensions});

  Vector2 _getPosition(MazeTileCoordinates coordinates) {
    switch (coordinates.angle) {
      case MazeTileAngle.zero:
        return Vector2(
          mazeDimensions.gameWidthStart +
              coordinates.horizontalIndex * (mazeDimensions.tileSize.x +mazeDimensions.tileSpace.x) +
              mazeDimensions.tileSize.x / 2.0 +
            mazeDimensions.tileSpace.x / 2.0,
          mazeDimensions.gameHeightStart +
              coordinates.verticalIndex * (mazeDimensions.tileSize.x +mazeDimensions.tileSpace.y),
        );
      case MazeTileAngle.perpendicular:
        return Vector2(
          mazeDimensions.gameWidthStart +
              coordinates.horizontalIndex * (mazeDimensions.tileSize.x +mazeDimensions.tileSpace.x),
          mazeDimensions.gameHeightStart +
              coordinates.verticalIndex * (mazeDimensions.tileSize.x +mazeDimensions.tileSpace.y) +
              mazeDimensions.tileSize.x / 2.0 +
              mazeDimensions.tileSpace.y / 2.0,
        );
    }
  }

  MazeTile createTile(MazeTileCoordinates coordinates) {
    return MazeTile(
      position: _getPosition(coordinates),
      size: mazeDimensions.tileSize,
      color: Colors.amber,
      angle: coordinates.angle.value,
    );
  }
}
