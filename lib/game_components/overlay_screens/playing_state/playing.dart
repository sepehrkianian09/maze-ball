import 'package:flutter/material.dart';
import 'package:maze_ball/game_components/game.dart';
import 'package:maze_ball/game_components/game_page.dart';

class PlayingOverlayScreen extends StatelessWidget {
  final MazeBallGame game;
  const PlayingOverlayScreen(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 32.0),
        child: OutlinedButton(
          onPressed: () {
            game.playingState = PlayingState.pause;
          },
          child: const Text("Pause"),
        ),
      ),
    );
  }
}
