import 'package:flame/events.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class HoverOutlineHudButton extends HudButtonComponent with HoverCallbacks {
  HoverOutlineHudButton({
    required super.button,
    required super.onPressed,
    super.position,
  });

  @override
  void onHoverEnter() {}

  @override
  void onHoverExit() {}

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final rect = button!.toRect();
    final paint =
        Paint()
          ..color = (isHovered ? Colors.yellow : Colors.blue)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    canvas.drawRect(rect, paint);
  }
}
