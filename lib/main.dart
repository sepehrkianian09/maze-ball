import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/game.dart';

void main() {
  runApp(GameWidget.controlled(gameFactory: MazeBallGame.new));
}
