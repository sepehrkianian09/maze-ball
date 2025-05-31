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

  Vector2 get start {
    return theVector - position.normalized() / 2.0;
  }

  Vector2 get end {
    return theVector + position.normalized() / 2.0;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint =
        Paint()
          ..color = color
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    // Draw main line
    canvas.drawLine(start.toOffset(), end.toOffset(), paint);

    // Draw arrowhead
    final arrowLength = 10.0;
    final angle = atan2(end.y - start.y, end.x - start.x);

    final arrowAngle = pi / 6; // 30 degrees
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
