import 'dart:async';
import 'package:flutter/material.dart';
import 'main_page.dart'; // Import your MainPage
import 'package:flutter/material.dart';

class LogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // **Gradient Shader for Ring & Letters**
    final Rect gradientRect = Rect.fromLTWH(0, 0, size.width, size.height);
    final Paint gradientPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.deepPurple, Colors.orangeAccent, Colors.blue, Colors.cyan],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(gradientRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0
      ..strokeCap = StrokeCap.round;

    // **Outer Circle (Gradient Ring)**
    final Paint ringPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.orangeAccent, Colors.deepPurple, Colors.blue, Colors.cyan],
      ).createShader(gradientRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width / 2.2,
      ringPaint,
    );

    // **Letter "A" with Gradient**
    Path aPath = Path();
    aPath.moveTo(size.width * 0.3, size.height * 0.7);
    aPath.lineTo(size.width * 0.5, size.height * 0.3);
    aPath.lineTo(size.width * 0.7, size.height * 0.7);
    aPath.moveTo(size.width * 0.4, size.height * 0.55);
    aPath.lineTo(size.width * 0.6, size.height * 0.55);

    canvas.drawPath(aPath, gradientPaint);

    // **Letter "M" with Gradient**
    Path mPath = Path();
    mPath.moveTo(size.width * 0.2, size.height * 0.7);
    mPath.lineTo(size.width * 0.3, size.height * 0.4);
    mPath.lineTo(size.width * 0.5, size.height * 0.6);
    mPath.lineTo(size.width * 0.7, size.height * 0.4);
    mPath.lineTo(size.width * 0.8, size.height * 0.7);

    canvas.drawPath(mPath, gradientPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Animation Controller for Logo Scaling
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    // Navigate to MainPage after 3 seconds
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const MainPage(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Adjust the color if needed
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: SizedBox(
            width: 200,
            height: 200,
            child: CustomPaint(
              painter: LogoPainter(),
            ),
          ),
        ),
      ),
    );
  }
}
