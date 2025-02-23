import 'package:developer_portfolio/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/responsive_widget.dart';



class Skill {
  final String skill;
  final int percentage;

  Skill({required this.skill, required this.percentage});
}

List<Skill> skills = [
  Skill(skill: "Dart", percentage: 62),
  Skill(skill: "JavaScript", percentage: 80),
  Skill(skill: "PHP", percentage: 78),
  Skill(skill: "Python", percentage: 90),
  Skill(skill: "GoLang", percentage: 40),
];

class SkillSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: ResponsiveWidget(
        desktop: _buildUi(context, kDesktopMaxWidth),
        tablet: _buildUi(context, kTabletMaxWidth),
        mobile: _buildUi(context, getMobileMaxWidth(context)),
      ),
    );
  }

  Widget _buildUi(BuildContext context, double width) {
    bool isMobile = ResponsiveWidget.isMobile(context);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: width),
        child: Flex(
          direction: isMobile ? Axis.vertical : Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobile) ...[
              Expanded(
                flex: 2,
                child:Icon(Icons.person)
              ),
              const SizedBox(width: 50.0),
            ],
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkillHeader(),
                  const SizedBox(height: 15.0),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      return SkillBar(skill: skills[index]);
                    },
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

/// **Skill Section Header**
class SkillHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "SKILLS",
          style: GoogleFonts.oswald(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 28.0,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 10.0),
        Text(
          "Below are my core technical skills. More will be added as I continue learning and improving.",
          style: TextStyle(
            
            height: 1.5,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }
}

/// **Skill Bar Widget**
class SkillBar extends StatelessWidget {
  final Skill skill;

  const SkillBar({Key? key, required this.skill}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Row(
        children: [
          Expanded(
            flex: skill.percentage,
            child: Container(
              padding: const EdgeInsets.only(left: 10.0),
              alignment: Alignment.centerLeft,
              height: 38.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                skill.skill,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            flex: 100 - skill.percentage,
            child: Container(
              height: 38.0,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Text(
            "${skill.percentage}%",
            style: TextStyle(color: Colors.white, fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
