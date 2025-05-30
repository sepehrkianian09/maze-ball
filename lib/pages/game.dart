import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/overlay_screens/welcome.dart';

enum PlayState { welcome, playing, gameOver, won }

class GamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameWidget(game: MazeBallGame(), overlayBuilderMap: {
      PlayState.welcome.name: (context, game) => WelcomeOverlayScreen(game as MazeBallGame)
    },));
  }
}
