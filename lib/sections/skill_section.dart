import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Skill {
  final String skill;
  final int percentage;
  final IconData icon;

  Skill({required this.skill, required this.percentage, required this.icon});
}

// **Updated Skill List with Icons**
List<Skill> skills = [
  Skill(skill: "Dart", percentage: 90, icon: FontAwesomeIcons.code),
  Skill(skill: "SQL", percentage: 80, icon: FontAwesomeIcons.database),
  Skill(skill: "PHP", percentage: 65, icon: FontAwesomeIcons.php),
  Skill(skill: "Python", percentage: 70, icon: FontAwesomeIcons.python),
  Skill(skill: "SQLite", percentage: 85, icon: FontAwesomeIcons.server),
  Skill(skill: "IoT Integration", percentage: 70, icon: FontAwesomeIcons.microchip),
];

class SkillSection extends StatelessWidget {
  final int index;
  final int activeIndex;

  const SkillSection({
    super.key,
    required this.index,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 900),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkillHeader(),
            const SizedBox(height: 20.0),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: skills.length,
              itemBuilder: (context, index) {
                return SkillBar(skill: skills[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// **Skill Section Header**
class SkillHeader extends StatelessWidget {
  const SkillHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "SKILLS",
          style: GoogleFonts.montserrat(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 26.0,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          "Below are my core technical skills. More will be added as I continue learning and improving.",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            color: Colors.black54,
            fontSize: 16.0,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

/// **Skill Bar with Icons**
class SkillBar extends StatelessWidget {
  final Skill skill;

  const SkillBar({super.key, required this.skill});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
      child: Row(
        children: [
          // **Filled Skill Bar with Gradient Border**
          Expanded(
            flex: skill.percentage,
            child: Container(
              height: 38.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: CustomPaint(
                painter: GradientBorderPainter(
                  borderWidth: 2, // Border thickness
                  gradient: LinearGradient(
                    colors: [Colors.purpleAccent, Colors.deepPurple],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    children: [
                      FaIcon(skill.icon, color: Colors.purple, size: 18), // Skill Icon
                      const SizedBox(width: 8), // Space between icon and text
                      Text(
                        skill.skill,
                        style: GoogleFonts.montserrat(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10.0),

          // **Unfilled Portion**
          Expanded(
            flex: 100 - skill.percentage,
            child: Container(
              height: 1.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.purpleAccent, Colors.deepPurple],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),

          const SizedBox(width: 10.0),

          // **Percentage Text**
          Text(
            "${skill.percentage}%",
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontSize: 14.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// **Custom Painter for Gradient Border**
class GradientBorderPainter extends CustomPainter {
  final double borderWidth;
  final Gradient gradient;

  GradientBorderPainter({required this.borderWidth, required this.gradient});

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;

    final Paint borderPaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final RRect roundedRect = RRect.fromRectAndRadius(
      rect,
      Radius.circular(5),
    );

    canvas.drawRRect(roundedRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
