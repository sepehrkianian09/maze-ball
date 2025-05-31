import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class OutlinedRectangleComponent extends PositionComponent {
  final Color color;
  final double strokeWidth;

  OutlinedRectangleComponent({
    required Vector2 position,
    required Vector2 size,
    this.color = Colors.white,
    this.strokeWidth = 2,
  }) {
    this.position = position;
    this.size = size;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawRect(size.toRect(), paint);
  }
}