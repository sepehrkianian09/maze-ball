import 'package:flutter/material.dart';
import 'package:maze_ball/game.dart';
import 'package:maze_ball/game_page.dart';

class GameOverOverlayScreen extends StatelessWidget {
  final MazeBallGame game;
  final double score = 10.0;

  const GameOverOverlayScreen(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black45, width: 2.0),
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10.0,
              children: [
                Text("Game Over"),
                Text("Lost on level ${game.level}"),
                OutlinedButton(
                  onPressed: () {
                    game.playState = PlayState.welcome;
                  },
                  child: Text("Return"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
