import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_framework/responsive_framework.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = ResponsiveBreakpoints.of(context).largerThan(TABLET);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Title
          Text(
            "EXPERIENCE",
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            "Professional Work Experience",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.black54,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 50.0),

          // **Row for Large Screens, Column for Small Screens**
          LayoutBuilder(
            builder: (context, constraints) {
              return isLargeScreen
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildExperienceItem(
                          company: "Herin Electronics",
                          role: "Software Development Engineer",
                          duration: "January 2025 – Present",
                          icon: FontAwesomeIcons.laptopCode,
                        )),
                        const SizedBox(width: 20),
                        Expanded(child: _buildExperienceItem(
                          company: "Herin Electronics",
                          role: "Application Engineer",
                          duration: "January 2023 – January 2025",
                          icon: FontAwesomeIcons.mobileScreen,
                        )),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _buildExperienceItem(
                          company: "Herin Electronics",
                          role: "Software Development Engineer",
                          duration: "January 2025 – Present",
                          icon: FontAwesomeIcons.laptopCode,
                        ),
                        const SizedBox(height: 20),
                        _buildExperienceItem(
                          company: "Herin Electronics",
                          role: "Application Engineer",
                          duration: "January 2023 – January 2025",
                          icon: FontAwesomeIcons.mobileScreen,
                        ),
                      ],
                    );
            },
          ),
        ],
      ),
    );
  }

  /// **Reusable Experience Item**
  Widget _buildExperienceItem({
    required String company,
    required String role,
    required String duration,
    required IconData icon,
  }) {
    return IntrinsicHeight( // Ensures both cards have the same height
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black12, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Role Icon
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.black12, width: 1.5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: FaIcon(icon, color: Colors.black87, size: 26),
            ),
            const SizedBox(width: 16.0),

            // Job Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    role,
                    style: GoogleFonts.montserrat(
                      color: Colors.purple,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    company,
                    style: GoogleFonts.montserrat(
                      color: Colors.black87,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    duration,
                    style: GoogleFonts.montserrat(
                      color: Colors.black54,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
