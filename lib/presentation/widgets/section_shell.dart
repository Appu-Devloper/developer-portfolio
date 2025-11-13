import 'package:flutter/material.dart';

/// Shared container that gives every section the same glassy surface.
class SectionShell extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final bool highlight;

  const SectionShell({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(32),
    this.margin = const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors =
        highlight
            ? [
              const Color(0xFFF8F2FF).withValues(alpha: 0.95),
              const Color(0xFFEFF6FF).withValues(alpha: 0.9),
            ]
            : [
              Colors.white.withValues(alpha: 0.94),
              Colors.white.withValues(alpha: 0.9),
            ];

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 40,
            offset: const Offset(0, 24),
          ),
        ],
      ),
      child: child,
    );
  }
}
