import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:maze_ball/pages/game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: GamePage());
  }
}
