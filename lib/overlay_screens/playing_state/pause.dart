import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/pages/game.dart';

class PauseOverlayScreen extends StatelessWidget {
  final MazeBallGame game;

  const PauseOverlayScreen(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Paused"),
          OutlinedButton(
            onPressed: () {
              game.playingState = PlayingState.playing;
            },
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }
}
