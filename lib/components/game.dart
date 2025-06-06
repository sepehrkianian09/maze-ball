import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:maze_ball/components/level_instance.dart';
import 'package:maze_ball/pages/game.dart';

import 'background.dart';

class MazeBallGame extends Forge2DGame with KeyboardEvents, TapDetector {
  MazeBallGame()
    : super(
        gravity: Vector2(0, 10),
        camera: CameraComponent.withFixedResolution(width: 600, height: 800),
      ) {
    _playState = PlayState.welcome;
  }

  @override
  FutureOr<void> onLoad() async {
    final backgroundImage = await images.load('background/colored_grass.png');
    await world.add(Background(sprite: Sprite(backgroundImage)));
    playState = PlayState.welcome;

    

    return super.onLoad();
  }

  LevelInstance? get levelInstance {
    return _levelInstance;
  }

  LevelInstance? _levelInstance;

  void _startGame() async {
    await world.add(_levelInstance = LevelInstance(level: _level));
    print("game started");
  }

  void _finishGame() {
    world.remove(_levelInstance!);
    _levelInstance = null;
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
        _levelInstance?.rightKey();
      } else if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
        _levelInstance?.leftKey();
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }

  bool _isPaused = false;
  @override
  void onTapDown(TapDownInfo info) {
    // if (_isPaused) {
    //   _isPaused = false;
    //   resumeEngine();
    //   overlays.remove('Pause');
    // } else {
    //   _isPaused = true;
    //   overlays.add('Pause');
    //   pauseEngine();
    // }
  }
}
