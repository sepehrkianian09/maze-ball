import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maze_ball/components/game.dart';

class WelcomeOverlayScreen extends StatelessWidget {
  final MazeBallGame game;

  const WelcomeOverlayScreen(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: startGame, child: Text("Start Game")),
    );
  }

  void startGame() {
    game.startGame();
  }
}
