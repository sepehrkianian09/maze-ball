import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

abstract class MazeDimensions {
  int get horizontalLength;
  int get verticalLength;

  double get gameWidth;
  double get gameWidthStart;

  double get gameHeight;
  double get gameHeightStart;

  Vector2 get tileSize;
  Vector2 get tileSpace;
}

class SpecificMazeDimensions implements MazeDimensions {
  @override
  final int horizontalLength;
  @override
  final int verticalLength;

  @override
  late double gameWidth;
  @override
  late double gameWidthStart;

  @override
  late double gameHeight;
  @override
  late double gameHeightStart;

  SpecificMazeDimensions({
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

  @override
  final tileSize = Vector2(12, 2);

  @override
  Vector2 get tileSpace {
    return Vector2(
      gameWidth / horizontalLength - tileSize.x,
      gameHeight / verticalLength - tileSize.x,
    );
  }
}


class SquareMazeDimensions implements MazeDimensions {
  SquareMazeDimensions({required Forge2DGame game, required this.level}) {
    final gameRect = game.camera.visibleWorldRect;
    gameWidthStart = gameRect.left;
    gameHeightStart = gameRect.top;

    double gameWidth = gameRect.right - gameRect.left;
    double gameHeight = gameRect.bottom - gameRect.top;
    length = min(gameWidth, gameHeight);

    numberOfTiles = __getN(level);
  }

  final double _sizeSpaceRatio = 0.9;

  double get _tileSizeX {
    return (length / numberOfTiles) * _sizeSpaceRatio;
  }

  double get _tileSizeY {
    return _tileSpace / 2;
  }

  @override
  Vector2 get tileSize {
    return Vector2(_tileSizeX, _tileSizeY);
  }

  double get _tileSpace {
    return (length / numberOfTiles) * (1 - _sizeSpaceRatio);
  }

  @override
  Vector2 get tileSpace {
    return Vector2(_tileSpace, _tileSpace);
  }

  @override
  late final double gameHeightStart;

  @override
  late final double gameWidthStart;

  late final double length;

  @override
  double get gameHeight {
    return length;
  }

  @override
  double get gameWidth {
    return length;
  }

  final int level;

  late final int numberOfTiles;

  bool isN(int n, int level) {
    return level >= (n - 1) * (n - 2) && level < n * (n - 1);
  }

  int __getN(int level) {
    double levelSqrt = sqrt(level);

    List<int> probableNs = [levelSqrt.floor() + 1, levelSqrt.ceil() + 1];
    for (int probableN in probableNs) {
      if (isN(probableN, level)) {
        return probableN;
      }
    }

    throw Error();
  }

  @override
  int get horizontalLength {
    return numberOfTiles;
  }

  @override
  int get verticalLength {
    return numberOfTiles;
  }
}
