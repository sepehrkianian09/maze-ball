import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/overlay_screens/game_over.dart';
import 'package:maze_ball/overlay_screens/pause.dart';
import 'package:maze_ball/overlay_screens/playing.dart';
import 'package:maze_ball/overlay_screens/result.dart';
import 'package:maze_ball/overlay_screens/welcome.dart';

enum PlayState { welcome, play, won, gameOver }

enum PlayingState { playing, pause }

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameWidget(
        game: MazeBallGame(),
        overlayBuilderMap: {
          PlayState.welcome.name:
              (context, game) => WelcomeOverlayScreen(game as MazeBallGame),
          PlayState.won.name:
              (context, game) => ResultOverlayScreen(game as MazeBallGame),
          PlayState.gameOver.name:
              (context, game) => GameOverOverlayScreen(game as MazeBallGame),
          PlayingState.playing.name:
              (context, game) => PlayingOverlayScreen(game as MazeBallGame),
          PlayingState.pause.name:
              (context, game) => PauseOverlayScreen(game as MazeBallGame),
        },
      ),
    );
  }
}
