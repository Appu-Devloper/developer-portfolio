import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../core/utils/image_painter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final List<String> techPhrases = [
    "Designing soulful Flutter experiences",
    "Architecting resilient backends",
    "Shipping IoT-powered products",
    "Blending code with storytelling",
  ];

  final List<Map<String, String>> heroStats = [
    {"value": "08+", "label": "Products shipped"},
    {"value": "2+ yrs", "label": "Industry exp"},
    {"value": "06 live", "label": "Apps in store"},
  ];

  final List<String> highlightBadges = [
    "Flutter & Dart",
    "IoT + Cloud",
    "Realtime Dashboards",
    "REST & SQL",
  ];

  late final AnimationController _floatController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: Center(
        child: ResponsiveRowColumn(
          rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
          layout:
              ResponsiveBreakpoints.of(context).largerThan(MOBILE)
                  ? ResponsiveRowColumnType.ROW
                  : ResponsiveRowColumnType.COLUMN,
          children: [
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: _buildAdaptiveHomeScreenText(context),
              ),
            ),
            ResponsiveRowColumnItem(
              rowFlex: 1,
              child: Padding(
                padding: EdgeInsets.all(30),
                child: _buildHomeScreenImage(context),
              ),
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

  /// Hero text content with animated highlights & CTA buttons.
  Widget _buildAdaptiveHomeScreenText(BuildContext context) {
    final double headlineSize =
        ResponsiveValue<double>(
          context,
          defaultValue: 40.0,
          conditionalValues: [
            Condition.largerThan(name: TABLET, value: 46.0),
            Condition.largerThan(name: DESKTOP, value: 54.0),
            Condition.largerThan(name: '4K', value: 64.0),
          ],
        ).value;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.08),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAvailabilityBadge(),
          const SizedBox(height: 18),
          Text(
            "Namaste, I'm",
            style: GoogleFonts.montserrat(
              color: Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          Text(
            "Appu M",
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontSize: headlineSize,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "Software Development Engineer blending Flutter craft, backend architecture, "
            "and tactile IoT experiences for ambitious teams.",
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontSize: 18,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 18),
          DefaultTextStyle(
            style: GoogleFonts.montserrat(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(milliseconds: 1200),
              animatedTexts:
                  techPhrases
                      .map(
                        (phrase) => TyperAnimatedText(
                          phrase,
                          speed: const Duration(milliseconds: 70),
                        ),
                      )
                      .toList(),
            ),
          ),
          const SizedBox(height: 24),
          _buildHighlightChips(),
          const SizedBox(height: 28),
          _buildCtas(),
          const SizedBox(height: 30),
          _buildStatsRow(),
        ],
      ),
    );
  }

  Widget _buildAvailabilityBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            "Currently crafting at Herin Electronics",
            style: GoogleFonts.montserrat(
              color: Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightChips() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children:
          highlightBadges
              .map(
                (badge) => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(
                      color: Colors.purple.withValues(alpha: 0.18),
                    ),
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
                      const Icon(
                        Icons.auto_awesome,
                        size: 16,
                        color: Colors.purple,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        badge,
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }

  Widget _buildCtas() {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        FilledButton.icon(
          onPressed: _launchEmail,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          icon: const Icon(Icons.chat_bubble_outline_rounded),
          label: Text(
            "Let's collaborate",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        OutlinedButton.icon(
          onPressed: _openResume,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
            side: BorderSide(color: Colors.purple.withValues(alpha: 0.4)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          icon: const Icon(Icons.picture_as_pdf_outlined, color: Colors.purple),
          label: Text(
            "View resume",
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children:
          heroStats
              .map(
                (stat) => Container(
                  width: 160,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 18,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        stat["value"]!,
                        style: GoogleFonts.montserrat(
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        stat["label"]!,
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: Colors.black54,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
    );
  }

  Future<void> _launchEmail() async {
    const emailUrl =
        'mailto:appua0126@gmail.com?subject=Let%27s%20build%20something%20impactful';
    await _launchLink(emailUrl);
  }

  Future<void> _openResume() async {
    const resumeUrl =
        'https://drive.google.com/file/d/1OsgwhMoAMdSRXodqqAC2kgUaai6Wz34P/view';
    await _launchLink(resumeUrl);
  }

  Future<void> _launchLink(String url) async {
    final launched = await launchUrlString(url);
    if (!launched && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Couldn't open $url", style: GoogleFonts.montserrat()),
        ),
      );
    }
  }

  /// **🖼️ Home Screen Image (Now Larger)**
  Widget _buildHomeScreenImage(BuildContext context) {
    final double canvasWidth =
        ResponsiveValue<double>(
          context,
          defaultValue: 350.0,
          conditionalValues: [
            Condition.largerThan(name: TABLET, value: 420.0),
            Condition.largerThan(name: DESKTOP, value: 500.0),
            Condition.largerThan(name: '4K', value: 580.0),
          ],
        ).value;

    final double canvasHeight =
        ResponsiveValue<double>(
          context,
          defaultValue: 290.0,
          conditionalValues: [
            Condition.largerThan(name: TABLET, value: 350.0),
            Condition.largerThan(name: DESKTOP, value: 450.0),
            Condition.largerThan(name: '4K', value: 520.0),
          ],
        ).value;

    final double avatarHeight =
        ResponsiveValue<double>(
          context,
          defaultValue: 260.0,
          conditionalValues: [
            Condition.largerThan(name: TABLET, value: 300.0),
            Condition.largerThan(name: DESKTOP, value: 350.0),
            Condition.largerThan(name: '4K', value: 420.0),
          ],
        ).value;

    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final double wave = math.sin(_floatController.value * math.pi * 2) * 16;
        final double tilt =
            math.sin(_floatController.value * math.pi * 2) * 0.02;
        return Transform(
          transform:
              Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(tilt),
          alignment: Alignment.center,
          child: Transform.translate(offset: Offset(0, wave), child: child),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.white.withValues(alpha: 0.75),
          border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withValues(alpha: 0.12),
              blurRadius: 50,
              offset: const Offset(0, 30),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(canvasWidth, canvasHeight),
              painter: CustomImageBackground(),
            ),
            Positioned(
              top: 24,
              right: 24,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.rocket_launch,
                      size: 16,
                      color: Colors.purple,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Shipping now",
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  "Flutter • IoT • Backend",
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Image.asset(
              "assets/avatar.png",
              height: avatarHeight,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
