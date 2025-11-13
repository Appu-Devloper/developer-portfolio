import 'package:developer_portfolio/presentation/widgets/section_shell.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';
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
  bool _isImageLoaded = false;

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
        bool isActive = widget.index == widget.activeIndex;

        return Center(
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: isActive ? 1.0 : 0.85,
            child: SectionShell(
              highlight: isActive,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
              child:
                  isLargeScreen
                      ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Stack(
                                children: [
                                  if (!_isImageLoaded) _shimmerPlaceholder(),
                                  Image.asset(
                                    'assets/appdevlopment.png',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 320,
                                    frameBuilder: (context, child, frame, _) {
                                      _isImageLoaded = true;
                                      if (frame == null) {
                                        return _shimmerPlaceholder();
                                      }
                                      return AnimatedOpacity(
                                        opacity: _isImageLoaded ? 1.0 : 0.0,
                                        duration: const Duration(
                                          milliseconds: 500,
                                        ),
                                        child: child,
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return _errorPlaceholder();
                                    },
                                  ),
                                ],
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
          ),
        );
      },
    );
  }

  Widget _shimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _errorPlaceholder() {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Center(
        child: Icon(Icons.error, color: Colors.red, size: 40),
      ),
    );
  }

  Widget _aboutMeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
          alignment:
              widget.index == widget.activeIndex
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
        _sectionTitle("How I add value"),
        const SizedBox(height: 12),
        _buildFocusHighlights(),
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

  Widget _buildFocusHighlights() {
    final List<Map<String, dynamic>> focusAreas = [
      {
        "icon": FontAwesomeIcons.diagramProject,
        "title": "Product thinking",
        "body":
            "Translate business goals into crisp, testable engineering tasks.",
      },
      {
        "icon": FontAwesomeIcons.microchip,
        "title": "IOT + Flutter bridge",
        "body":
            "Pair hardware signals with beautiful UIs and resilient backends.",
      },
      {
        "icon": FontAwesomeIcons.gaugeHigh,
        "title": "Perf obsessed",
        "body":
            "Profile, optimize, and ship apps that stay under 16ms frame budgets.",
      },
    ];

    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children:
          focusAreas
              .map(
                (item) => Container(
                  width: 220,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FaIcon(
                        item["icon"] as IconData,
                        color: Colors.purple,
                        size: 20,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        item["title"] as String,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item["body"] as String,
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          height: 1.5,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }

  Widget _buildTechGrid() {
    List<Map<String, dynamic>> techList = [
      {"icon": FontAwesomeIcons.flutter, "label": "Flutter"},
      {"icon": FontAwesomeIcons.python, "label": "Python"},
      {"icon": FontAwesomeIcons.database, "label": "SQL"},
      {"icon": FontAwesomeIcons.microchip, "label": "IoT"},
      {"icon": FontAwesomeIcons.cloud, "label": "REST"},
    ];

    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children:
          techList
              .map((tech) => _techContainer(tech['icon'], tech['label']))
              .toList(),
    );
  }

  Widget _techContainer(IconData icon, String label) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        double angle = _controller.value * 2 * pi;
        double dx = 5 * cos(angle);
        double dy = 5 * sin(angle);

        return Transform.translate(
          offset: Offset(dx, dy),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.white, Color(0xFFF6F0FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.purple.withValues(alpha: 0.2)),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withValues(alpha: 0.08),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(icon, color: Colors.purple, size: 18),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
