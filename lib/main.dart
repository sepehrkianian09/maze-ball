import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:maze_ball/configure.dart';
import 'package:maze_ball/game_page.dart';

Future<void> main() async {
  await Configure().specify();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: GamePage());
  }
}
