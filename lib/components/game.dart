import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/services/keyboard_key.g.dart';
import 'package:maze_ball/components/helpers.dart';
import 'package:maze_ball/components/helpers/vector.dart';
import 'package:maze_ball/components/maze.dart';
import 'package:maze_ball/components/collectibles/cell_coordinates.dart';
import 'package:maze_ball/components/collectibles/heart.dart';
import 'package:maze_ball/pages/game.dart';

import 'background.dart';
import 'collectibles/ball.dart';
import 'helpers/text.dart';
import 'tile/maze_dimensions.dart';

class MazeBallGame extends Forge2DGame with KeyboardEvents {
  MazeBallGame()
    : super(
        gravity: Vector2(0, 10),
        camera: CameraComponent.withFixedResolution(width: 800, height: 600),
      ) {
    _playState = PlayState.welcome;
  }

  MazeDimensions get mazeDimensions {
    return MazeDimensions(game: this, horizontalLength: 4, verticalLength: 4);
  }

  CellCoordinatesConverter get cellCoordinatesConverter {
    return CellCoordinatesConverter(mazeDimensions: mazeDimensions);
  }

  @override
  FutureOr<void> onLoad() async {
    final backgroundImage = await images.load('background/colored_grass.png');
    await world.add(Background(sprite: Sprite(backgroundImage)));
    playState = PlayState.welcome;

    return super.onLoad();
  }

  Maze? _maze;

  Ball? _ball;
  get ball => _ball;
  Heart? _heart;

  MazeBallHelpers? _helpers;

  void _startGame() async {
    await world.add(_maze = Maze(level: _level));

    Random theRandom = Random();
    await world.add(
      _ball = Ball(
        position: cellCoordinatesConverter.convert(
          CellCoordinates(
            theRandom.nextInt(mazeDimensions.horizontalLength),
            theRandom.nextInt(mazeDimensions.verticalLength),
          ),
        ),
        level: _level,
      ),
    );

    // TODO what if heart and ball have the same coordinates?
    await world.add(
      _heart = Heart(
        position: cellCoordinatesConverter.convert(
          CellCoordinates(
            theRandom.nextInt(mazeDimensions.horizontalLength),
            theRandom.nextInt(mazeDimensions.verticalLength),
          ),
        ),
      ),
    );

    await world.add(_helpers = MazeBallHelpers(this));
    print("game started");
  }

  void _finishGame() {
    world.remove(_helpers!);
    _helpers = null;

    world.remove(_maze!);
    _maze = null;

    world.remove(_ball!);
    _ball = null;

    world.remove(_heart!);
    _heart = null;

    print("game finished");
  }

  int _level = 1;

  void goToNextLevel() {
    _finishGame();
    _level += 1;
    _startGame();
  }

  int getScore() {
    return _level - 1;
  }

  late PlayState _playState;
  PlayState get playState => _playState;
  set playState(PlayState playState) {
    switch (_playState) {
      case PlayState.welcome:
      case PlayState.won:
      case PlayState.gameOver:
        overlays.remove(_playState.name);
        break;
      case PlayState.playing:
        _finishGame();
        break;
    }
    _playState = playState;
    switch (_playState) {
      case PlayState.won:
      case PlayState.gameOver:
      case PlayState.welcome:
        overlays.add(_playState.name);
        break;
      case PlayState.playing:
        _level = 1;
        _startGame();
        break;
    }
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;

    // print("event pressed $event");

    if (isKeyDown) {
      if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
        _ball!.body.gravityOverride?.rotate(pi / 2);
        _ball!.body.linearVelocity.setZero();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        _ball!.body.gravityOverride?.rotate(-pi / 2);
        _ball!.body.linearVelocity.setZero();
      }

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
