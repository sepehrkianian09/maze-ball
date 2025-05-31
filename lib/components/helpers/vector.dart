import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

class VectorHelper extends PositionComponent {
  final Vector2 thePosition;
  final Vector2 theVector;
  final Color color;

  VectorHelper({
    required this.thePosition,
    required this.theVector,
    required this.color,
  });

  final double _scale = 5.0;

  Vector2 get start {
    return thePosition;
  }

  Vector2 get end {
    return thePosition + theVector.normalized() * _scale;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 1.5
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
