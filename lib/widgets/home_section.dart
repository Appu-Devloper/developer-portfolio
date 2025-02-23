import 'dart:async';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/image_painter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> techPhrases = [
    "💻 Crafting Digital Experiences",
    "💡 Innovating with Code",
    "🚀 Building the Future",
    "⚡ Tech, Code, and Creativity"
  ];

  int _currentPhraseIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _startTextAnimation();
  }

  void _startTextAnimation() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        _currentPhraseIndex = (_currentPhraseIndex + 1) % techPhrases.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
 final Color backgroundColor = Color(0xFFF0F4F8); // Soft Grey-Blue Background

  @override
  Widget build(BuildContext context) {
    return ResponsiveBreakpoints.builder(
      child: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [backgroundColor, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: ResponsiveRowColumn(
            rowMainAxisAlignment: MainAxisAlignment.spaceEvenly,
            layout: ResponsiveBreakpoints.of(context).largerThan(MOBILE)
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
      ),
      breakpoints: [
        const Breakpoint(start: 0, end: 480, name: MOBILE),
        const Breakpoint(start: 481, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1200, name: DESKTOP),
        const Breakpoint(start: 1201, end: 2460, name: '4K'),
      ],
    );
  }

  /// **📝 Text Section (Now with Animated Phrases)**
  Widget _buildAdaptiveHomeScreenText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "👋 Hello there!..",
          style: GoogleFonts.oswald(
            color: Colors.black87,
            fontWeight: FontWeight.w700,
            fontSize: ResponsiveValue<double>(
              context,
              defaultValue: 22.0,
              conditionalValues: [
                Condition.largerThan(name: TABLET, value: 26.0),
                Condition.largerThan(name: DESKTOP, value: 30.0),
                Condition.largerThan(name: '4K', value: 34.0),
              ],
            ).value,
          ),
        ),
        SizedBox(height: 15),
        Text(
          "Appu M",
          style: GoogleFonts.lora(
            color: Colors.black87,
            fontSize: ResponsiveValue<double>(
              context,
              defaultValue: 36.0,
              conditionalValues: [
                Condition.largerThan(name: TABLET, value: 42.0),
                Condition.largerThan(name: DESKTOP, value: 50.0),
                Condition.largerThan(name: '4K', value: 58.0),
              ],
            ).value,
            fontWeight: FontWeight.w900,
          ),
        ),
         SizedBox(height: 15),
        Text(
          "Software Development Engineer",
          style: GoogleFonts.oswald(
            color: Colors.black54,
            fontSize: ResponsiveValue<double>(
              context,
              defaultValue: 24.0, // Increased from 20
              conditionalValues: [
                Condition.largerThan(name: TABLET, value: 28.0),
                Condition.largerThan(name: DESKTOP, value: 32.0),
              ],
            ).value,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 15),
  
        /// **🌀 Animated Tech-Oriented Text**
        AnimatedSwitcher(
          duration: Duration(milliseconds: 800),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Text(
            techPhrases[_currentPhraseIndex],
            key: ValueKey(_currentPhraseIndex),
            style: GoogleFonts.lora(
              color: Colors.black,
             fontSize: 16,fontWeight: FontWeight.bold
              
            ),
          ),
        ),
        SizedBox(height: 12),

        Text(
          "Crafting intuitive and high-performance apps with elegant code.",
          style: GoogleFonts.lora(
            color: Colors.black87,
            fontSize: ResponsiveValue<double>(
              context,
              defaultValue: 18.0,
              conditionalValues: [
                Condition.largerThan(name: TABLET, value: 20.0),
                Condition.largerThan(name: DESKTOP, value: 22.0),
              ],
            ).value,
            height: 1.5,
          ),
        ),
        SizedBox(height: 12),
        Text(
          "Ready to transform your ideas into seamless digital solutions?",
          style: GoogleFonts.lora(
            color: Colors.black87,
            fontSize: ResponsiveValue<double>(
              context,
              defaultValue: 18.0,
              conditionalValues: [
                Condition.largerThan(name: TABLET, value: 20.0),
                Condition.largerThan(name: DESKTOP, value: 22.0),
              ],
            ).value,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// **🖼️ Home Screen Image (Now Larger)**
  Widget _buildHomeScreenImage(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(
            ResponsiveValue<double>(
              context,
              defaultValue: 350.0,
              conditionalValues: [
                Condition.largerThan(name: TABLET, value: 420.0),
                Condition.largerThan(name: DESKTOP, value: 500.0),
                Condition.largerThan(name: '4K', value: 580.0),
              ],
            ).value,
            ResponsiveValue<double>(
              context,
              defaultValue: 290.0,
              conditionalValues: [
                Condition.largerThan(name: TABLET, value: 350.0),
                Condition.largerThan(name: DESKTOP, value: 450.0),
                Condition.largerThan(name: '4K', value: 520.0),
              ],
            ).value,
          ),
          painter: CustomImageBackground(),
        ),
        Image.asset(
          "assets/avatar.png", // Make sure the path is correct
          height: ResponsiveValue<double>(
            context,
            defaultValue: 260.0,
            conditionalValues: [
              Condition.largerThan(name: TABLET, value: 300.0),
              Condition.largerThan(name: DESKTOP, value: 350.0),
              Condition.largerThan(name: '4K', value: 420.0),
            ],
          ).value,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
