import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class AboutMeScreen extends StatefulWidget {
  final int index;
  final int activeIndex;

  const AboutMeScreen({
    super.key,
    required this.index,
    required this.activeIndex,
  });

  @override
  _AboutMeScreenState createState() => _AboutMeScreenState();
}

class _AboutMeScreenState extends State<AboutMeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(); // Loop the animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isLargeScreen = constraints.maxWidth > 800;

        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
            child: isLargeScreen
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/appdevlopment.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        flex: 6,
                        child: SingleChildScrollView(
                          child: _aboutMeContent(),
                        ),
                      ),
                    ],
                  )
                : _aboutMeContent(),
          ),
        );
      },
    );
  }

  Widget _aboutMeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          alignment: widget.index == widget.activeIndex
              ? Alignment.center
              : Alignment.centerLeft,
          child: _sectionTitle("Who I Am & What Drives Me"),
        ),
        _subTitle("A journey of passion, creativity, and technology"),
        const SizedBox(height: 20),
        _highlightedText("My Story & Purpose"),
        const SizedBox(height: 10),
        _bodyText(
          "I'm Appu M, a Software Development Engineer with expertise in Flutter, Dart, Python, and SQL. "
          "I specialize in backend development, IoT integration, and real-time data visualization.",
        ),
        const SizedBox(height: 10),
        _bodyText(
          "With 2+ years of experience, I have designed and developed scalable mobile applications and IoT solutions. "
          "I have expertise in optimizing SQL databases, implementing RESTful APIs, and integrating real-time data pipelines. "
          "Currently, I am working as a Software Development Engineer at Herin Electronics, where I contribute to building innovative "
          "tech solutions that enhance operational efficiency.",
        ),
        const SizedBox(height: 20),
        _sectionTitle("Technologies I have worked with"),
        const SizedBox(height: 10),
        _buildTechGrid(),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _subTitle(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(fontSize: 16, color: Colors.black54),
    );
  }

  Widget _highlightedText(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: Colors.purple,
      ),
    );
  }

  Widget _bodyText(String text) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
        fontSize: 16,
        color: Colors.black87,
        height: 1.5,
      ),
    );
  }

  Widget _buildTechGrid() {
    List<Map<String, dynamic>> techList = [
      {"icon": FontAwesomeIcons.flutter, "label": "Flutter"},
      {"icon": FontAwesomeIcons.python, "label": "Python"},
      {"icon": FontAwesomeIcons.database, "label": "SQL"},
      {"icon": FontAwesomeIcons.microchip, "label": "IoT"},
      {"icon": FontAwesomeIcons.cloud, "label": "REST APIs"},
    ];

    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children:
          techList.map((tech) => _techContainer(tech['icon'], tech['label'])).toList(),
    );
  }

  Widget _techContainer(IconData icon, String label) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // Circular movement
        double angle = _controller.value * 2 * pi; // Convert progress to radians
        double dx = 5 * cos(angle); // Horizontal movement
        double dy = 5 * sin(angle); // Vertical movement

        return Transform.translate(
          offset: Offset(dx, dy),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.white, Colors.white54],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.black26),
            ),
            child: FaIcon(icon, color: Colors.purple, size: 25),
          ),
        );
      },
    );
  }
}
