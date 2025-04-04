import 'package:flutter/material.dart';

class CustomImageBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // === 1. Base Gradient Background ===
    Paint backgroundPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.blue.withOpacity(0.25), // Used as if .withValues(alpha: 0.25)
          Colors.purple.withOpacity(0.25),
          Colors.pink.withOpacity(0.25),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    // === 2. Central Glow (subtle, dreamy) ===
    Paint glowPaint = Paint()
      ..color = Colors.white.withOpacity(0.15)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 35);

    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.45),
      size.width * 0.35,
      glowPaint,
    );

    // === 3. Bottom Fluid Wave Shape ===
    Path curvePath = Path()
      ..moveTo(0, size.height * 0.75)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.65,
        size.width * 0.75,
        size.height * 0.85,
        size.width,
        size.height * 0.7,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    Paint curvePaint = Paint()
      ..color = Colors.white.withOpacity(0.08);

    canvas.drawPath(curvePath, curvePaint);

    // === 4. Soft, Abstract Bokeh Circles ===
    final circlePaint = Paint()..style = PaintingStyle.fill;

    final List<Map<String, dynamic>> softSpots = [
      {
        'color': Colors.cyanAccent.withOpacity(0.25),
        'position': Offset(size.width * 0.2, size.height * 0.25),
        'radius': size.width * 0.15,
      },
      {
        'color': Colors.pinkAccent.withOpacity(0.2),
        'position': Offset(size.width * 0.75, size.height * 0.2),
        'radius': size.width * 0.12,
      },
      {
        'color': Colors.purple.withOpacity(0.2),
        'position': Offset(size.width * 0.65, size.height * 0.65),
        'radius': size.width * 0.1,
      },
    ];

    for (var spot in softSpots) {
      circlePaint.color = spot['color'];
      canvas.drawCircle(spot['position'], spot['radius'], circlePaint);
    }

    // === 5. Decorative Line ===
    Path waveLine = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(
        size.width * 0.35, size.height * 0.6,
        size.width * 0.7, size.height * 0.7,
      )
      ..quadraticBezierTo(
        size.width * 0.9, size.height * 0.75,
        size.width, size.height * 0.68,
      );

    Paint wavePaint = Paint()
      ..color = Colors.white.withOpacity(0.12)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    canvas.drawPath(waveLine, wavePaint);
  }

  @override
  bool shouldRepaint(CustomImageBackground oldDelegate) => false;
}
