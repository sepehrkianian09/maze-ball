import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maze_ball/game.dart';
import 'package:maze_ball/overlay_screens/utils.dart';
import 'package:maze_ball/game_page.dart';

class ResultOverlayScreen extends StatelessWidget {
  final MazeBallGame game;
  final double score = 10.0;

  const ResultOverlayScreen(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black),
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: CircularPainter(),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Score: $score"),
              ElevatedButton(onPressed: startGame, child: Text("Restart Game")),
            ],
          ),
        ),
      ],
    );
  }

  void startGame() {
    game.playState = PlayState.play;
  }
}
