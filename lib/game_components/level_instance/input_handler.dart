import 'package:flutter/services.dart';

abstract class InputHandler {
  void handleKey(LogicalKeyboardKey key);
}
