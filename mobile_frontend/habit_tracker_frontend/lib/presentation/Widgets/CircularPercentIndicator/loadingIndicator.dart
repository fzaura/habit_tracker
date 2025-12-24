import 'dart:math';
import 'package:flutter/material.dart';

class HabitLoadingIndicator extends StatefulWidget {
  final double size;
  final double strokeWidth;

  const HabitLoadingIndicator({
    super.key,
    this.size = 60.0,
    this.strokeWidth = 6.0,
  });

  @override
  State<HabitLoadingIndicator> createState() => _HabitLoadingIndicatorState();
}

class _HabitLoadingIndicatorState extends State<HabitLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
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
        // Adding a slight pulse to the size to make it "pop"
        final pulse = 1.0 + (sin(_controller.value * 2 * pi) * 0.05);
        
        return Transform.scale(
          scale: pulse,
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _OrangeGlowPainter(
              animationValue: _controller.value,
              strokeWidth: widget.strokeWidth,
            ),
          ),
        );
      },
    );
  }
}

class _OrangeGlowPainter extends CustomPainter {
  final double animationValue;
  final double strokeWidth;

  const _OrangeGlowPainter({
    required this.animationValue,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);

    // 1. The "Outer Glow" - This creates the fuzzy orange aura
    final glowPaint = Paint()
      ..color = Colors.orange.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth * 2.5
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8); // Deep Blur

    canvas.drawCircle(center, radius, glowPaint);

    // 2. The Base Track (Dim Orange)
    final basePaint = Paint()
      ..color = Colors.orange.withOpacity(0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(center, radius, basePaint);

    // 3. The Animated High-Intensity Sweep
    final sweepPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..shader = SweepGradient(
        colors: [
          Colors.orange.withOpacity(0.1),
          Colors.orangeAccent, // Bright highlight
          Colors.deepOrange,   // Rich tail
          Colors.orange.withOpacity(0.1),
        ],
        stops: const [0.0, 0.4, 0.6, 1.0],
        transform: GradientRotation(animationValue * 2 * pi),
      ).createShader(rect);

    canvas.drawCircle(center, radius, sweepPaint);
  }

  @override
  bool shouldRepaint(_OrangeGlowPainter oldDelegate) =>
      oldDelegate.animationValue != animationValue;
}