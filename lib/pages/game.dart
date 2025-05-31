import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/overlay_screens/result.dart';
import 'package:maze_ball/overlay_screens/welcome.dart';

enum PlayState { welcome, playing, result }

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
          PlayState.result.name:
              (context, game) => ResultOverlayScreen(game as MazeBallGame),
        },
      ),
    );
  }
}
