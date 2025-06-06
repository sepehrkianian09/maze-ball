import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../../utils/outlined_rectangle.dart';

class TextHelper extends PositionComponent {
  final String Function() textShower;

  late final TextComponent _theComponent;

  TextHelper({
    required super.position,
    required this.textShower,
    required Color color,
    Anchor anchor = Anchor.topLeft,
  }) {
    add(
      _theComponent = TextComponent(
        position: Vector2.zero(),
        anchor: anchor,
        textRenderer: TextPaint(
          style: TextStyle(
            fontSize: 2,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    add(
      OutlinedRectangleComponent(
        position: Vector2.zero(),
        anchor: anchor,
        size: Vector2(10.0, 4.0),
        strokeWidth: 0.3,
      ),
    );
  }

  @override
  void render(Canvas canvas) {
    _theComponent.text = textShower();
    super.render(canvas);
  }
}
