import 'package:flutter/material.dart';

/// Shared container that gives every section the same glassy surface.
class SectionShell extends StatelessWidget {
  final Widget child;
  final bool highlight;

  const SectionShell({
    super.key,
    required this.child,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final bool isMobile = width <= 640;
    final EdgeInsetsGeometry adaptivePadding = isMobile
        ? const EdgeInsets.symmetric(horizontal: 20, vertical: 24)
        : const EdgeInsets.all(32);
    final EdgeInsetsGeometry adaptiveMargin = isMobile
        ? const EdgeInsets.symmetric(vertical: 14, horizontal: 4)
        : const EdgeInsets.symmetric(vertical: 32, horizontal: 16);
    final double borderRadius = isMobile ? 24 : 32;

    final List<Color> gradientColors = highlight
        ? [
            const Color(0xFFF8F2FF).withValues(alpha: 0.95),
            const Color(0xFFEFF6FF).withValues(alpha: 0.9),
          ]
        : [
            Colors.white.withValues(alpha: 0.94),
            Colors.white.withValues(alpha: 0.9),
          ];

    return Container(
      margin: adaptiveMargin,
      padding: adaptivePadding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: isMobile ? 24 : 40,
            offset: Offset(0, isMobile ? 16 : 24),
          ),
        ],
      ),
      child: child,
    );
  }
}
