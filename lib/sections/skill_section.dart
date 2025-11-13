import 'package:developer_portfolio/presentation/widgets/section_shell.dart';
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
  Skill(
    skill: "IoT Integration",
    percentage: 70,
    icon: FontAwesomeIcons.microchip,
  ),
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
      child: SectionShell(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: SkillHeader()),
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
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: skill.percentage / 100),
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return SizedBox(
            height: 56,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: value,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.deepPurple, Colors.purpleAccent],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Row(
                    children: [
                      FaIcon(skill.icon, color: Colors.white, size: 18),
                      const SizedBox(width: 10),
                      Text(
                        skill.skill,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "${skill.percentage}%",
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
