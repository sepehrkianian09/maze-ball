import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

void main() {
  runApp(GameWidget.controlled(gameFactory: Forge2DGame.new));
}
