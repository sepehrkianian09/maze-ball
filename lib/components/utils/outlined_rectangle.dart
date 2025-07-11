import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class OutlinedRectangleComponent extends PositionComponent {
  final Color color;
  final double strokeWidth;

  OutlinedRectangleComponent({
    required Vector2 position,
    required Vector2 size,
    super.anchor = Anchor.topLeft,
    this.color = Colors.white,
    this.strokeWidth = 2,
  }) {
    this.position = position;
    this.size = size;
  }

  // TODO what about changing anchors?
  @override
  set size(Vector2 size) {
    final vertices = sizeToVertices(super.size, anchor);
    position += vertices[0];

    super.size = size;
    final vertices2 = sizeToVertices(size, anchor);
    position -= vertices2[0];
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint =
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth;

    // canvas.drawRect(size.toRect(), paint);
    canvas.drawPath(_getPath(sizeToVertices(size, anchor)), paint);
  }

  Path _getPath(List<Vector2> vertices) {
    final path = Path()..moveTo(vertices[0].x, vertices[0].y);

    for (int i = 1; i < vertices.length; i++) {
      path.lineTo(vertices[i].x, vertices[i].y);
    }
    path.close(); // optional, closes the shape

    return path;
  }

  @protected
  static List<Vector2> sizeToVertices(Vector2 size, Anchor? componentAnchor) {
    final anchor = componentAnchor ?? Anchor.topLeft;
    return [
      Vector2(-size.x * anchor.x, -size.y * anchor.y),
      Vector2(-size.x * anchor.x, size.y - size.y * anchor.y),
      Vector2(size.x - size.x * anchor.x, size.y - size.y * anchor.y),
      Vector2(size.x - size.x * anchor.x, -size.y * anchor.y),
    ];
  }
}
