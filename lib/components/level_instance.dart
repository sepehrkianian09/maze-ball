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

  Ball? _ball;
  get ball => _ball;

  @override
  FutureOr<void> onLoad() async {
    mazeDimensions = MazeDimensions(
      game: game,
      horizontalLength: 4,
      verticalLength: 4,
    );

    cellCoordinatesConverter = CellCoordinatesConverter(
      mazeDimensions: mazeDimensions,
    );

    await add(Maze(level: level, mazeDimensions: mazeDimensions));

    Random theRandom = Random();
    await add(
      _ball = Ball(
        position: cellCoordinatesConverter.convert(
          CellCoordinates(
            theRandom.nextInt(mazeDimensions.horizontalLength),
            theRandom.nextInt(mazeDimensions.verticalLength),
          ),
        ),
        level: level,
      ),
    );

    // TODO what if heart and ball have the same coordinates?
    await add(
      Heart(
        position: cellCoordinatesConverter.convert(
          CellCoordinates(
            theRandom.nextInt(mazeDimensions.horizontalLength),
            theRandom.nextInt(mazeDimensions.verticalLength),
          ),
        ),
      ),
    );

    await add(MazeBallHelpers(levelInstance: this));

    return super.onLoad();
  }

  void handleKeys(Set<LogicalKeyboardKey> keysPressed) {
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      _ball!.body.gravityOverride?.rotate(pi / 2);
      _ball!.body.linearVelocity.setZero();
    } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      _ball!.body.gravityOverride?.rotate(-pi / 2);
      _ball!.body.linearVelocity.setZero();
    }
  }
}
