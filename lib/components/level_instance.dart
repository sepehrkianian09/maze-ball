import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/components/level_instance/helpers.dart';
import 'package:maze_ball/components/level_instance/maze.dart';

import 'level_instance/collectibles/ball.dart';
import 'level_instance/collectibles/cell_coordinates.dart';
import 'level_instance/collectibles/heart.dart';
import 'level_instance/tile/maze_dimensions.dart';

class LevelInstance extends PositionComponent
    with HasGameReference<MazeBallGame> {
  final int level;

  LevelInstance({required this.level});

  late final MazeDimensions mazeDimensions;
  late final CellCoordinatesConverter cellCoordinatesConverter;

  late final Ball ball;
  late final Heart heart;

  @override
  FutureOr<void> onLoad() async {
    mazeDimensions = SquareMazeDimensions(game: game, level: level);

    cellCoordinatesConverter = CellCoordinatesConverter(
      mazeDimensions: mazeDimensions,
    );

    Random theRandom = Random();
    CellCoordinates ballCellCoordinates = CellCoordinates(
      theRandom.nextInt(mazeDimensions.horizontalLength),
      theRandom.nextInt(mazeDimensions.verticalLength - 1),
    );
    await add(
      ball = Ball(
        cellCoordinates: ballCellCoordinates,
        position: cellCoordinatesConverter.convert(ballCellCoordinates),
        level: level,
        radius: max(mazeDimensions.tileSpace.x, mazeDimensions.tileSpace.y),
      ),
    );

    CellCoordinates heartCellCoordinates = CellCoordinates(
      theRandom.nextInt(mazeDimensions.horizontalLength),
      theRandom.nextInt(mazeDimensions.verticalLength),
    );
    while (heartCellCoordinates == ballCellCoordinates) {
      heartCellCoordinates = CellCoordinates(
        theRandom.nextInt(mazeDimensions.horizontalLength),
        theRandom.nextInt(mazeDimensions.verticalLength),
      );
    }
    await add(
      heart = Heart(
        cellCoordinates: heartCellCoordinates,
        position: cellCoordinatesConverter.convert(heartCellCoordinates),
      ),
    );

    await add(
      Maze(level: level, mazeDimensions: mazeDimensions, levelInstance: this),
    );

    await add(
      MazeBallHelpers(levelInstance: this, position: Vector2(-30, 24)),
    );

    return super.onLoad();
  }

  void handleKeys(Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      ball.body.gravityOverride?.rotate(pi / 2);
      ball.body.linearVelocity.setZero();
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      ball.body.gravityOverride?.rotate(-pi / 2);
      ball.body.linearVelocity.setZero();
    }
  }
}
