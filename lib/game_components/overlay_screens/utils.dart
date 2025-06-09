import 'package:flutter/material.dart';

class CircularWhiteBackground extends StatelessWidget {
  const CircularWhiteBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: MediaQuery.of(context).size,
      painter: CircularPainter(),
    );
  }
}

class CircularPainter extends CustomPainter {
  final double shrinkRatio;

  CircularPainter({this.shrinkRatio = 4.0});

  @override
  void paint(Canvas canvas, Size size) {
    // Fill the background with black
    final backgroundPaint = Paint()..color = Colors.black;
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    // Draw a circular white area in the center
    final whiteCirclePaint = Paint()..color = Colors.white;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / shrinkRatio; // Adjust as needed
    canvas.drawCircle(center, radius, whiteCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
