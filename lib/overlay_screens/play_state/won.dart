import 'package:flutter/material.dart';
import 'package:maze_ball/game.dart';
import 'package:maze_ball/game_page.dart';

class WonOverlayScreen extends StatelessWidget {
  final MazeBallGame game;

  const WonOverlayScreen(this.game, {super.key});

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
              borderRadius: BorderRadius.circular(16), 
            ),
            padding: EdgeInsets.all(32.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10.0,
              children: [
                Text("Congratulations!\nYou completed the game.", textAlign: TextAlign.center,),
                OutlinedButton(
                  onPressed: () {
                    game.playState = PlayState.welcome;
                  },
                  child: const Text("Return"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void startGame() {
    game.playState = PlayState.play;
  }
}
