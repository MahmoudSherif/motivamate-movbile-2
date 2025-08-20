import 'package:flutter/material.dart';
import 'dart:math' as math;

class SpaceBackground extends StatefulWidget {
  final Widget child;

  const SpaceBackground({super.key, required this.child});

  @override
  State<SpaceBackground> createState() => _SpaceBackgroundState();
}

class _SpaceBackgroundState extends State<SpaceBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  final List<Star> _stars = [];
  final int _starCount = 150;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _generateStars();
  }

  void _generateStars() {
    final random = math.Random();
    for (int i = 0; i < _starCount; i++) {
      _stars.add(Star(
        x: random.nextDouble(),
        y: random.nextDouble(),
        size: random.nextDouble() * 3 + 1,
        speed: random.nextDouble() * 0.5 + 0.1,
        opacity: random.nextDouble() * 0.8 + 0.2,
        twinkleSpeed: random.nextDouble() * 2 + 1,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF0F172A),
            Color(0xFF1E293B),
            Color(0xFF334155),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated stars
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: StarFieldPainter(_stars, _controller.value),
                size: Size.infinite,
              );
            },
          ),
          // Content
          widget.child,
        ],
      ),
    );
  }
}

class Star {
  double x;
  double y;
  final double size;
  final double speed;
  final double opacity;
  final double twinkleSpeed;

  Star({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.twinkleSpeed,
  });
}

class StarFieldPainter extends CustomPainter {
  final List<Star> stars;
  final double animationValue;

  StarFieldPainter(this.stars, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.white;

    for (var star in stars) {
      // Update star position
      star.y += star.speed * 0.01;
      if (star.y > 1.0) {
        star.y = 0.0;
        star.x = math.Random().nextDouble();
      }

      // Calculate twinkle effect
      final twinkle = (math.sin(animationValue * math.pi * 2 * star.twinkleSpeed) + 1) / 2;
      final currentOpacity = star.opacity * twinkle;

      paint.color = Colors.white.withOpacity(currentOpacity);

      // Draw star
      final x = star.x * size.width;
      final y = star.y * size.height;

      // Draw a small cross for larger stars, circles for smaller ones
      if (star.size > 2) {
        _drawCross(canvas, paint, Offset(x, y), star.size);
      } else {
        canvas.drawCircle(Offset(x, y), star.size, paint);
      }
    }
  }

  void _drawCross(Canvas canvas, Paint paint, Offset center, double size) {
    final path = Path();
    
    // Vertical line
    path.moveTo(center.dx, center.dy - size);
    path.lineTo(center.dx, center.dy + size);
    
    // Horizontal line
    path.moveTo(center.dx - size, center.dy);
    path.lineTo(center.dx + size, center.dy);
    
    canvas.drawPath(path, paint..strokeWidth = 0.5..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(StarFieldPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue;
  }
}