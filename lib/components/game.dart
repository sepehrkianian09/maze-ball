import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maze_ball/components/game_world.dart';
import 'package:maze_ball/pages/game.dart';

import 'background.dart';
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

  @override
  FutureOr<void> onLoad() async {
    final backgroundImage = await images.load('background/colored_grass.png');
    await world.add(Background(sprite: Sprite(backgroundImage)));
    playState = PlayState.welcome;

    return super.onLoad();
  }

  GameWorld? _gameWorld;

  void _startGame() async {
    await world.add(_gameWorld = GameWorld(gameInstance: this, level: _level));
    print("game started");
  }

  void _finishGame() {
    world.remove(_gameWorld!);
    _gameWorld = null;
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
      _gameWorld?.handleKeys(keysPressed);

      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
