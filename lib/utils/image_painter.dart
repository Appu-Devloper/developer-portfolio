

import 'package:flutter/material.dart';

class CustomImageBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background Gradient Paint
    Paint backgroundPaint =
        Paint()
          ..shader = LinearGradient(
            colors: [
              Colors.blue.withOpacity(0.25),
              Colors.purple.withOpacity(0.25),
              Colors.pink.withOpacity(0.25),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
          ..style = PaintingStyle.fill;

    // Draw a Soft Curved Background
    Path backgroundPath =
        Path()
          ..moveTo(0, size.height * 0.6)
          ..quadraticBezierTo(
            size.width * 0.25,
            size.height * 0.3,
            size.width * 0.5,
            size.height * 0.5,
          )
          ..quadraticBezierTo(
            size.width * 0.75,
            size.height * 0.7,
            size.width,
            size.height * 0.6,
          )
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();

    canvas.drawPath(backgroundPath, backgroundPaint);

    // Circular Color Splashes (Soft Abstract Spots)
    Paint circlePaint = Paint()..style = PaintingStyle.fill;
    List<Color> colors = [
      Colors.blueAccent.withOpacity(0.3),
      Colors.purpleAccent.withOpacity(0.3),
      Colors.pinkAccent.withOpacity(0.3),
      Colors.cyanAccent.withOpacity(0.3),
    ];

    for (int i = 0; i < colors.length; i++) {
      circlePaint.color = colors[i];

      canvas.drawCircle(
        Offset(size.width * (0.3 + i * 0.1), size.height * (0.3 + i * 0.15)),
        size.width * 0.12,
        circlePaint,
      );
    }

    // Glow Effect Behind Image
    Paint glowPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.15)
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20);

    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.5),
      size.width * 0.3,
      glowPaint,
    );

    // Elegant Wave Stroke Line
    Paint wavePaint =
        Paint()
          ..color = Colors.white.withOpacity(0.6)
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke;

    Path wavePath =
        Path()
          ..moveTo(0, size.height * 0.55)
          ..quadraticBezierTo(
            size.width * 0.25,
            size.height * 0.4,
            size.width * 0.5,
            size.height * 0.5,
          )
          ..quadraticBezierTo(
            size.width * 0.75,
            size.height * 0.6,
            size.width,
            size.height * 0.55,
          );

    canvas.drawPath(wavePath, wavePaint);
  }

  @override
  bool shouldRepaint(CustomImageBackground oldDelegate) => false;
}
