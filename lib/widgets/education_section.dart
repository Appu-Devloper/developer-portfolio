import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
        alignment: Alignment.center,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// **About Me Section**
              Text(
                "MY STORY",
                style: GoogleFonts.oswald(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 32.0,
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                "I am a results-driven Software Development Engineer with expertise in Flutter, Dart, Python, and SQL. "
                "I specialize in designing scalable software solutions, integrating IoT systems, and optimizing backend performance. "
                "Passionate about technology and solving real-world problems through efficient and maintainable code.",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16.0,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40.0),

              /// **Experience Section**
              Text(
                "WORK EXPERIENCE",
                style: GoogleFonts.oswald(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 28.0,
                ),
              ),
              const SizedBox(height: 20.0),

              /// **Work Experience List**
              _buildSection(experienceList),

              const SizedBox(height: 50.0),

              /// **Education Section**
              Text(
                "EDUCATION",
                style: GoogleFonts.oswald(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                  fontSize: 28.0,
                ),
              ),
              const SizedBox(height: 20.0),

              /// **Education List**
              _buildSection(educationList),
            ],
          ),
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

  /// **Reusable Section for Work Experience & Education**
  Widget _buildSection(List<SectionItem> sectionItems) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = ResponsiveBreakpoints.of(context).smallerThan(TABLET);
        return Wrap(
          spacing: isMobile ? 0 : 20.0,
          runSpacing: 20.0,
          children: sectionItems.map(
            (item) {
              return Container(
               
                width: isMobile ? double.infinity : (constraints.maxWidth / 2) - 20.0,
               
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.oswald(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                        fontSize: 20.0,
                      ),
                    ),
                    Text(
                      item.period,
                      style: GoogleFonts.oswald(
                        color: Colors.black54,
                        fontWeight: FontWeight.w400,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      item.description,
                      style: TextStyle(
                        color: Colors.black,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              );
            },
          ).toList(),
        );
      },
    );
  }
}

/// **Common Data Model for Experience & Education**
class SectionItem {
  final String title;
  final String description;
  final String period;

  SectionItem({
    required this.title,
    required this.description,
    required this.period,
  });
}

/// **Work Experience List**
final List<SectionItem> experienceList = [
  SectionItem(
    title: "Software Development Engineer",
    description: "Developed scalable software and IoT solutions, integrating real-time device data.",
    period: "Jan 2025 – Present",
  ),
  SectionItem(
    title: "Application Engineer",
    description: "Built high-performance Flutter apps with 5,000+ downloads, optimized backend architecture.",
    period: "Jan 2023 – Jan 2025",
  ),
];

/// **Education List**
final List<SectionItem> educationList = [
  SectionItem(
    title: "Master of Computer Applications (MCA)",
    description: "Karnataka State Open University, CGPA: 8.3. Specialized in software architecture and cloud computing.",
    period: "Sep 2023 – Present",
  ),
  SectionItem(
    title: "Bachelor of Computer Applications (BCA)",
    description: "Davangere University, CGPA: 8.9. Specialized in full-stack development and database management.",
    period: "Aug 2019 – Oct 2022",
  ),
];
