import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: CustomPaint(
            painter: BackgroundPainter(), // 🎨 Overlapping rectangles applied globally
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric( horizontal: 20.0),
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("MY STORY"),
                  _buildDescription(
                    "I am a results-driven Software Development Engineer with expertise in Flutter, Dart, Python, and SQL. "
                    "I specialize in designing scalable software solutions, integrating IoT systems, and optimizing backend performance. "
                    "Passionate about technology and solving real-world problems through efficient and maintainable code.",
                  ),
                  const SizedBox(height: 50.0),

                  _buildSectionTitle("WORK EXPERIENCE"),
                  const SizedBox(height: 20.0),
                  _buildTimeline(experienceList.reversed.toList()),

                  _buildSectionTitle("EDUCATION"),
                  const SizedBox(height: 20.0),
                  _buildEducationCards(educationList),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.oswald(
        color: Colors.black87,
        fontWeight: FontWeight.w700,
        fontSize: 32.0,
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildDescription(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.black87,
        fontSize: 16.0,
        height: 1.6,
      ),
    );
  }

  /// **Modern Work Experience Timeline**
  Widget _buildTimeline(List<SectionItem> sectionItems) {
    return Column(
      children: sectionItems.asMap().entries.map((entry) {
        int index = entry.key;
        SectionItem item = entry.value;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.4),
                          blurRadius: 12,
                          spreadRadius: 3,
                        ),
                      ],
                    ),
                  ),
                 
                    Container(
                      height: 50,
                      width: 2,
                      color: Colors.blueAccent.withOpacity(0.5),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.9),
                    border: Border.all(color: Colors.blueAccent.withOpacity(0.2)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.1),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.oswald(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        item.period,
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          color: Colors.blueGrey.shade700,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item.description,
                        style: GoogleFonts.poppins(
                          fontSize: 14.0,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// **Stylish Colored Education Cards**
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
              gradient: LinearGradient(
                colors: [Colors.blue.withOpacity(0.0), Colors.white.withOpacity(0.3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              border: Border.all(color: Colors.blueAccent.withOpacity(0.3), width: 1.5),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueAccent.withOpacity(0.1),
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
                    color: Colors.blueGrey.shade700,
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

/// 🎨 **Custom Painter for Background Overlapping Rectangles**
class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint1 = Paint()..color = Colors.blue.withOpacity(0.3);
    final Paint paint2 = Paint()..color = Colors.purple.withOpacity(0.3);

    // Top-left rectangle
    canvas.drawRect(
      Rect.fromLTWH(-50, -50, size.width * 0.4, size.height * 0.4),
      paint1,
    );

    // Bottom-right rectangle (Overlapping)
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.6, size.height * 0.6, size.width * 0.4, size.height * 0.4),
      paint2,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
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
