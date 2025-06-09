import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maze_ball/components/level_instance.dart';
import 'package:maze_ball/components/level_instance/input_handler.dart';
import 'package:maze_ball/controllers/level.dart';
import 'package:maze_ball/game_page.dart';

import 'components/background.dart';

class MazeBallGame extends Forge2DGame with KeyboardEvents, TapDetector {
  final _levelController = Get.find<LevelController>();

  MazeBallGame()
    : super(
        gravity: Vector2(0, 10),
        camera: CameraComponent.withFixedResolution(width: 600, height: 800),
      ) {
    _playState = PlayState.welcome;
    _playingState = PlayingState.playing;
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

  final int maxLevel = 16;

  int _level = 1;
  set level(int level) {
    _level = level;
  }

  void wonCurrentLevel() {
    if (_level == maxLevel) {
      _finishGame();
      playState = PlayState.won;
      return;
    }

    goToNextLevel();
  }

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
      case PlayState.play:
        _finishGame();
        break;
      default:
        overlays.remove(_playState.name);
        break;
    }
    _playState = playState;
    switch (_playState) {
      case PlayState.play:
        _startGame();
        playingState = PlayingState.playing;
        break;
      case PlayState.gameOver:
        _levelController.saveLevel(_level);
        overlays.add(_playState.name);
        break;
      case PlayState.won:
        _levelController.deleteSavedLevel();
        overlays.add(_playState.name);
        break;
      default:
        overlays.add(_playState.name);
        break;
    }
  }

  late PlayingState _playingState;
  PlayingState get playingState => _playingState;
  set playingState(PlayingState playingState) {
    switch (_playingState) {
      case PlayingState.pause:
        resumeEngine();
        overlays.remove(_playingState.name);
        break;
      case PlayingState.playing:
        overlays.remove(_playingState.name);
        break;
    }
    _playingState = playingState;
    switch (_playingState) {
      case PlayingState.pause:
        pauseEngine();
        overlays.add(_playingState.name);
        break;
      case PlayingState.playing:
        overlays.add(_playingState.name);
        break;
    }
  }

  InputHandler get _inputHandler {
    return levelInstance!;
  }

  @override
  KeyEventResult onKeyEvent(
    KeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is KeyDownEvent;

    // print("event pressed $event");
    if (isKeyDown) {
      for (var keyPressed in keysPressed) {
        _inputHandler.handleKey(keyPressed);
      }
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}
