import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maze_ball/components/game.dart';

class WelcomeOverlayScreen extends StatelessWidget {
  final MazeBallGame game;

  const WelcomeOverlayScreen(this.game, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black),
        CustomPaint(
          size: MediaQuery.of(context).size,
          painter: CircularPainter(),
        ),
        Center(
          child: ElevatedButton(
            onPressed: startGame,
            child: Text("Start Game"),
          ),
        ),
      ],
    );
  }

  void startGame() {
    game.startGame();
  }
}

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
  @override
  void paint(Canvas canvas, Size size) {
    // Fill the background with black
    final backgroundPaint = Paint()..color = Colors.black;
    canvas.drawRect(Offset.zero & size, backgroundPaint);

    // Draw a circular white area in the center
    final whiteCirclePaint = Paint()..color = Colors.white;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.shortestSide / 4; // Adjust as needed
    canvas.drawCircle(center, radius, whiteCirclePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
