import 'dart:ui';
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
              _buildSectionTitle("MY STORY"),
              _buildDescription(
                "I am a results-driven Software Development Engineer with expertise in Flutter, Dart, Python, and SQL. "
                "I specialize in designing scalable software solutions, integrating IoT systems, and optimizing backend performance. "
                "Passionate about technology and solving real-world problems through efficient and maintainable code.",
              ),
              const SizedBox(height: 40.0),
    
              /// **Experience Section**
              _buildSectionTitle("WORK EXPERIENCE"),
              const SizedBox(height: 20.0),
              _buildStepper(experienceList.reversed.toList()),
    
              /// **Education Section**
              _buildSectionTitle("EDUCATION"),
              const SizedBox(height: 20.0),
              _buildEducationCards(educationList),
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

  /// **Section Title**
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.oswald(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 32.0,
      ),
    );
  }

  /// **Description Text**
  Widget _buildDescription(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.black87,
        fontSize: 16.0,
        height: 1.5,
      ),
    );
  }

  /// **Stepper for Work Experience**
  Widget _buildStepper(List<SectionItem> sectionItems) {
    return Stepper(
      elevation: 5,
      physics: ClampingScrollPhysics(),
      currentStep: sectionItems.length - 1,
      controlsBuilder: (context, _) => SizedBox.shrink(),
      steps: sectionItems.map((item) {
        return Step(
          title: Text(
            item.title,
            style: GoogleFonts.oswald(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.period,
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 5.0),
              Text(
                item.description,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 14.0,
                  height: 1.5,
                ),
              ),
            ],
          ),
          content: SizedBox.shrink(),
          isActive: true,
        );
      }).toList(),
    );
  }

  /// **New Card Design for Education**
  Widget _buildEducationCards(List<SectionItem> sectionItems) {
    return Wrap(
      spacing: 20.0,
      runSpacing: 20.0,
      children: sectionItems.map(
        (item) {
          return Container(
            width: 400,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white.withOpacity(0.9),
              border: Border.all(color: Colors.blueAccent.withOpacity(0.5), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 15,
                  spreadRadius: -3,
                  offset: Offset(3, 3),
                ),
              ],
            ),
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
                const SizedBox(height: 5),
                Text(
                  item.period,
                  style: GoogleFonts.poppins(
                    color: Colors.black54,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  item.description,
                  style: GoogleFonts.poppins(
                    color: Colors.black87,
                    fontSize: 14.0,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          );
        },
      ).toList(),
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
    description: "Developed scalable software solutions to meet business needs, ensuring high performance and maintainability.\n"
        "Integrated hardware components for seamless data processing and IoT connectivity.\n"
        "Implemented full-stack IoT solutions with backend scalability and responsive frontends.\n",
    period: "Jan 2025 – Present",
  ),
  SectionItem(
    title: "Application Engineer",
    description: "Built high-performance cross-platform applications with Flutter, surpassing 5,000+ downloads.\n"
        "Optimized SQL queries and backend processes, reducing response times significantly.\n"
        "Designed scalable database architectures to handle concurrent users and heavy loads.\n",
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
