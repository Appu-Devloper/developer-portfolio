import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';

/// Animated gradient backdrop with subtle motion graphics and frosted blobs.
class AnimatedPortfolioBackground extends StatefulWidget {
  final Widget child;

  const AnimatedPortfolioBackground({super.key, required this.child});

  @override
  State<AnimatedPortfolioBackground> createState() =>
      _AnimatedPortfolioBackgroundState();
}

class _AnimatedPortfolioBackgroundState
    extends State<AnimatedPortfolioBackground> {
  int _paletteIndex = 0;

  final List<List<Color>> _palettes = const [
    [Color(0xFFEEF2FF), Color(0xFFF1E6FF), Color(0xFFFFF7F0)],
    [Color(0xFFFDEBFF), Color(0xFFE6FFFA), Color(0xFFF3F2FF)],
    [Color(0xFFFFF1F0), Color(0xFFEAF2FF), Color(0xFFF7EDFF)],
  ];

  @override
  Widget build(BuildContext context) {
    final nextIndex = (_paletteIndex + 1) % _palettes.length;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(seconds: 10),
      curve: Curves.easeInOut,
      onEnd: () => setState(() => _paletteIndex = nextIndex),
      builder: (context, value, child) {
        final colors = List.generate(
          _palettes[_paletteIndex].length,
          (i) =>
              Color.lerp(
                _palettes[_paletteIndex][i],
                _palettes[nextIndex][i],
                value,
              )!,
        );

        final wave = math.sin(value * math.pi);
        final orbit = math.sin(value * math.pi * 2);

        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment(-0.8 + value * 0.6, -1),
              end: Alignment(0.8, 1 - value * 0.4),
            ),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: _OrbitalLinesPainter(progress: orbit),
                ),
              ),
              Positioned(
                top: 60 + wave * 24,
                left: -120,
                child: _GlassBlob(
                  size: 260,
                  opacity: 0.38,
                  colors: const [Color(0xFF6A11CB), Color(0xFF2575FC)],
                ),
              ),
              Positioned(
                bottom: -40,
                right: -20 + orbit * 20,
                child: _GlassBlob(
                  size: 220,
                  opacity: 0.32,
                  colors: const [Color(0xFFFF758C), Color(0xFFFF7EB3)],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.32,
                right: 32 + orbit * 16,
                child: _FloatingBadge(),
              ),
              child!,
            ],
          ),
        );
      },
      child: widget.child,
    );
  }
}

class _GlassBlob extends StatelessWidget {
  final double size;
  final double opacity;
  final List<Color> colors;

  const _GlassBlob({
    required this.size,
    required this.opacity,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors:
                  colors
                      .map((color) => color.withValues(alpha: opacity))
                      .toList(),
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(size),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatefulWidget {
  @override
  State<_FloatingBadge> createState() => _FloatingBadgeState();
}

class _FloatingBadgeState extends State<_FloatingBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final offset = math.sin(_controller.value * math.pi * 2) * 10;
        return Transform.translate(offset: Offset(0, offset), child: child);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.purple.withValues(alpha: 0.15),
              blurRadius: 18,
              spreadRadius: 1,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: Colors.greenAccent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              "Open for SDE roles",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrbitalLinesPainter extends CustomPainter {
  final double progress;

  const _OrbitalLinesPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint =
        Paint()
          ..color = Colors.white.withValues(alpha: 0.08)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2;

    final center = size.center(Offset.zero);
    final shortestSide = size.shortestSide;

    for (int i = 0; i < 3; i++) {
      final radius = shortestSide * (0.35 + i * 0.12);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2 + progress * 0.4 * (i + 1),
        math.pi * (1.1 + i * 0.2),
        false,
        linePaint..color = linePaint.color.withValues(alpha: 0.05 + i * 0.02),
      );
    }

    final Paint dotPaint =
        Paint()
          ..color = Colors.white.withValues(alpha: 0.35)
          ..style = PaintingStyle.fill;

    final radius = shortestSide * 0.45;
    final angle = progress * math.pi * 2;
    final Offset dotPosition = Offset(
      center.dx + radius * math.cos(angle),
      center.dy + radius * math.sin(angle),
    );

    canvas.drawCircle(dotPosition, 6, dotPaint);
  }

  @override
  bool shouldRepaint(covariant _OrbitalLinesPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
