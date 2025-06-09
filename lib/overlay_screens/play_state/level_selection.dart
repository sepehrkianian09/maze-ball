import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maze_ball/components/game.dart';
import 'package:maze_ball/overlay_screens/utils.dart';
import 'package:maze_ball/pages/game.dart';

class LevelSelectionOverlayScreen extends StatelessWidget {
  final MazeBallGame game;

  LevelSelectionOverlayScreen(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black),
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black45, width: 5),
              borderRadius: BorderRadius.circular(16), // Rounded corners
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10.0,
              children: [
                Flexible(child: SizedBox(width: 500, child: _levelGrid())),
                OutlinedButton(
                  onPressed: () {
                    game.playState = PlayState.welcome;
                  },
                  child: const Text("Back"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  final List<Color> difficultyColors = [
    Colors.orangeAccent,
    Colors.deepOrangeAccent,
    Colors.redAccent,
    Colors.deepPurpleAccent,
  ];

  Widget _levelGrid() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200, // max width per grid tile
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 4, // width/height ratio
      ),
      itemCount: game.maxLevel,
      itemBuilder: (context, index) {
        return Container(
          alignment: Alignment.center,
          // color: Colors.blueAccent,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: difficultyColors[sqrt(index + 1).ceil() - 1],
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              game.level = index + 1;
              game.playState = PlayState.play;
            },
            child: Text("level ${index + 1}"),
          ),
        );
      },
    );
  }
}
