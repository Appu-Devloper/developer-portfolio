import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: EnhancedGradientBackgroundPainter(),
          ),
        ),
        ResponsiveBreakpoints.builder(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 20.0),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                "OUR SERVICES",
                style: GoogleFonts.oswald(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 32.0,
                ),
              ),
                const SizedBox(height: 40.0),
                Wrap(
                  spacing: 40.0,
                  runSpacing: 40.0,
                  alignment: WrapAlignment.center,
                  children: [
                    // _buildServiceCard(
                    //   context,
                    //   icon: Icons.code,
                    //   title: "Software Development",
                    //   description:
                    //       "Designing and implementing scalable software solutions tailored to business needs, ensuring high performance,",
                    //   cardColor: Colors.pinkAccent,
                    //   features: ["Flutter", "Python", "SQL", "MQTT", "Clean Architecture"],
                    // ),
                    _buildServiceCard(
                      context,
                      icon: Icons.phone_android,
                      title: "Cross-Platform App Development",
                      description:
                          "Building high-quality mobile applications using Flutter and Dart with modern UI/UX principles and optimal performance.",
                      cardColor: Colors.tealAccent,
                      features: ["Flutter", "Dart", "MVVM Architecture", "State Management"],
                    ),
                    _buildServiceCard(
                      context,
                      icon: Icons.cloud,
                      title: "Backend & API Development",
                      description:
                          "Expert in designing and integrating scalable RESTful APIs, optimizing SQL databases, and handling real-time IoT data processing.",
                      cardColor: Colors.amberAccent,
                      features: ["SQL", "API Design", "Postman", "Firebase Cloud Messaging"],
                    ),
                    _buildServiceCard(
                      context,
                      icon: Icons.settings_remote,
                      title: "IoT & Embedded Systems",
                      description:
                          "Collaborating with hardware teams for seamless device integration, enabling real-time data visualization and efficient processing.",
                      cardColor: Colors.cyanAccent,
                      features: ["MQTT", "BLE", "WiFi", "IoT Dashboards"],
                    ),
                  ],
                ),
              ],
            ),
          ),
          breakpoints: [
            const Breakpoint(start: 0, end: 480, name: MOBILE),
            const Breakpoint(start: 481, end: 800, name: TABLET),
            const Breakpoint(start: 801, end: 1200, name: DESKTOP),
            const Breakpoint(start: 1201, end: 2460, name: '4K'),
          ],
        ),
      ],
    );
  }
  Widget _buildServiceCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String description,
      required Color cardColor,
      required List<String> features}) {
    return Container(
      width: 350,
      height: 350,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(color: cardColor.withOpacity(0.7), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 15,
            spreadRadius: -3,
            offset: Offset(3, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: cardColor.withOpacity(0.8)),
            SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.oswald(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            SizedBox(height: 12),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: features
                  .map(
                    (feature) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: cardColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        feature,
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

}
class EnhancedGradientBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white, Colors.grey.shade300],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    // Draw base gradient background
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), paint);

    // Draw curved wave overlay
    final Path wavePath = Path();
    wavePath.moveTo(0, size.height * 0.6);
    wavePath.quadraticBezierTo(
        size.width * 0.25, size.height * 0.5, size.width * 0.5, size.height * 0.6);
    wavePath.quadraticBezierTo(
        size.width * 0.75, size.height * 0.7, size.width, size.height * 0.5);
    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    final Paint wavePaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.tealAccent.withOpacity(0.2), Colors.blueAccent.withOpacity(0.2)],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    canvas.drawPath(wavePath, wavePaint);

    // Draw subtle overlay
    final Paint overlayPaint = Paint()
      ..shader = RadialGradient(
        colors: [Colors.white.withOpacity(0.3), Colors.transparent],
        center: Alignment.topCenter,
        radius: 1.5,
      ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));

    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), overlayPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
