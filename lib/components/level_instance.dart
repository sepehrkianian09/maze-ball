import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/components/helpers.dart';
import 'package:maze_ball/components/maze.dart';

import 'collectibles/ball.dart';
import 'collectibles/cell_coordinates.dart';
import 'collectibles/heart.dart';
import 'tile/maze_dimensions.dart';

class LevelInstance extends PositionComponent {
  final MazeBallGame gameInstance;

  final int level;

  LevelInstance({required this.gameInstance, required this.level}) {
    mazeDimensions = MazeDimensions(
      game: gameInstance,
      horizontalLength: 4,
      verticalLength: 4,
    );

    cellCoordinatesConverter = CellCoordinatesConverter(
      mazeDimensions: mazeDimensions,
    );
  }

  late final MazeDimensions mazeDimensions;
  late final CellCoordinatesConverter cellCoordinatesConverter;

  Ball? _ball;
  get ball => _ball;

  @override
  FutureOr<void> onLoad() async {
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

    await add(MazeBallHelpers(this));
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
