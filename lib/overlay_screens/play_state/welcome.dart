import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:maze_ball/game.dart';
import 'package:maze_ball/controllers/level.dart';
import 'package:maze_ball/overlay_screens/utils.dart';
import 'package:maze_ball/game_page.dart';

class WelcomeOverlayScreen extends StatelessWidget {
  final MazeBallGame game;

  WelcomeOverlayScreen(this.game, {super.key});

  final _levelController = Get.find<LevelController>();

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
                OutlinedButton(
                  onPressed:
                      _levelController.isLevelSaved()
                          ? () {
                            game.level = _levelController.retrieveLevel();
                            game.playState = PlayState.play;
                          }
                          : null,
                  child: const Text("Continue"),
                ),
                OutlinedButton(
                  onPressed: () {
                    game.level = 1;
                    game.playState = PlayState.play;
                  },
                  child: Text("Start Game"),
                ),
                OutlinedButton(
                  onPressed: () {
                    game.playState = PlayState.selectLevel;
                  },
                  child: const Text("Select Level"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
