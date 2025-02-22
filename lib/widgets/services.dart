import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ServicesScreen extends StatelessWidget {
  final Color primaryColor = Color(0xFF0077B6); // Soft Blue Theme
  final Color backgroundColor = Color(0xFFF0F4F8); // Soft Grey-Blue Background

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColor, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "OUR SERVICES",
              style: GoogleFonts.oswald(
                color: Colors.black87,
                fontWeight: FontWeight.w700,
                fontSize: 32.0,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 20.0),

            /// **Service Cards with Feature Tags**
            Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
              alignment: WrapAlignment.center,
              children: [
                _buildServiceCard(
                  context,
                  icon: Icons.phone_android,
                  title: "App Development",
                  description:
                      "We create high-quality mobile apps for Android and iOS with modern UI, robust features, and best UX.",
                  features: ["Flutter", "Firebase", "State Management"],
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.palette,
                  title: "Frontend Solutions",
                  description:
                      "Building engaging UI designs, animations, and interactive elements for smooth user experiences.",
                  features: ["IoT Dashboards", "Live Data Stream", "WebSockets"],
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.speed,
                  title: "Performance Optimization",
                  description:
                      "Enhancing app speed, stability, and responsiveness for seamless, fast, and efficient digital solutions.",
                  features: ["Lazy Loading", "Code Splitting", "Caching"],
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
    );
  }

  /// **🎨 Glassmorphic Card with Feature Tags**
  Widget _buildServiceCard(BuildContext context,
      {required IconData icon,
      required String title,
      required String description,
      required List<String> features}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Card(
          color: backgroundColor,
          child: Container(
            width: 320,
            padding: EdgeInsets.all(20),
            // decoration: BoxDecoration(
            //   color: Colors.white60, // Glassmorphism effect
            //   borderRadius: BorderRadius.circular(0),
            //   border: Border.all(color: Colors.white.withOpacity(0.2)),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black12,
            //       blurRadius: 15,
            //       spreadRadius: 2,
            //     ),
            //   ],
            // ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: primaryColor),
                SizedBox(height: 15),
                Text(
                  title,
                  style: GoogleFonts.oswald(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 15),
          
                /// **🔹 Feature Tags**
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: features
                      .map(
                        (feature) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: primaryColor.withOpacity(0.5), width: 1),
                          ),
                          child: Text(
                            feature,
                            style: GoogleFonts.poppins(
                              color: primaryColor,
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
        ),
      ),
    );
  }
}
