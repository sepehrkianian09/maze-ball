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

    if (isHovered) {
      final rect = button!.toRect();
      final paint =
          Paint()
            ..color = Colors.yellow
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3;

      canvas.drawRect(rect, paint);
    }
  }
}
