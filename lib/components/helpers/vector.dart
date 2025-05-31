import 'dart:math';

import 'package:flame/components.dart';

import 'package:flutter/material.dart';
import 'package:maze_ball/components/utils/outlined_rectangle.dart';

class VectorHelper extends PositionComponent {
  final Vector2 theVector;
  final Color color;

  VectorHelper({
    required super.position,
    required this.theVector,
    required this.color,
    required String vectorName,
    required Color textColor,
  }) : super(scale: Vector2.all(0.75)) {
    add(
      TextComponent(
        position: Vector2(0, _scale + 2.0),
        text: vectorName,
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: TextStyle(
            fontSize: 2,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    double edge = 1.0;
    add(
      OutlinedRectangleComponent(
        position: Vector2(-_scale, -2.0 - edge) - Vector2.all(edge),
        size: Vector2(1, 1) * 2 * _scale + Vector2(1, 1) * 2 * edge + Vector2(0, edge * 3),
        strokeWidth: _scale * 0.1,
      ),
    );

    print("position: $position");
  }

  final double _scale = 3.0;

  Vector2 get start {
    return Vector2.zero();
  }

  Vector2 get end {
    return theVector.normalized() * _scale;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 0.3 * _scale
          ..style = PaintingStyle.stroke;

    // Draw main line
    canvas.drawLine(start.toOffset(), end.toOffset(), paint);

    // Draw arrowhead
    final arrowLength = _scale / 2.0;
    final angle = atan2(end.y - start.y, end.x - start.x);

    final arrowAngle = pi / 4; // 30 degrees
    final arrowPoint1 = Offset(
      end.x - arrowLength * cos(angle - arrowAngle),
      end.y - arrowLength * sin(angle - arrowAngle),
    );

    final arrowPoint2 = Offset(
      end.x - arrowLength * cos(angle + arrowAngle),
      end.y - arrowLength * sin(angle + arrowAngle),
    );

    canvas.drawLine(end.toOffset(), arrowPoint1, paint);
    canvas.drawLine(end.toOffset(), arrowPoint2, paint);
  }
}
