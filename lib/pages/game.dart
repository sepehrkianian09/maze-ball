import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/overlay_screens/game_over.dart';
import 'package:maze_ball/overlay_screens/pause.dart';
import 'package:maze_ball/overlay_screens/result.dart';
import 'package:maze_ball/overlay_screens/welcome.dart';

enum PlayState { welcome, playing, won, gameOver }

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
          'Pause': (context, game) => PauseOverlayScreen(),
        },
      ),
    );
  }
}
