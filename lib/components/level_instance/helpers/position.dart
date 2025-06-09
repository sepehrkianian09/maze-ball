import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:maze_ball/components/utils/outlined_rectangle.dart';

class PositionHelper extends PositionComponent {
  final Vector2 Function() positionFunction;
  final double squareSideLength;
  final double offset = 5.0;
  final String name;

  final Color color;

  PositionHelper({
    required this.positionFunction,
    required this.squareSideLength,
    required this.name,
    required this.color,
  });

  @override
  FutureOr<void> onLoad() async {
    await add(
      OutlinedRectangleComponent(
        position: Vector2.zero(),
        size: Vector2.all(squareSideLength + offset) + Vector2(0, 2.0),
        anchor: Anchor.center,
        strokeWidth: 0.5,
        color: color,
      ),
    );

    await add(
      TextComponent(
        position: Vector2(0, squareSideLength),
        anchor: Anchor.topCenter,
        text: name,
        textRenderer: TextPaint(
          style: TextStyle(
            fontSize: 1,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    position = positionFunction();
    super.render(canvas);
  }
}
