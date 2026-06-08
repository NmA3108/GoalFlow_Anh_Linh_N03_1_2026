import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const deep = Color(0xFF07085A);
  static const navy = Color(0xFF10177A);
  static const blue = Color(0xFF3158FF);
  static const violet = Color(0xFF9772FB);
  static const violetDark = Color(0xFF26186B);
  static const mint = Color(0xFF20F384);
  static const cream = Color(0xFFFFD587);
  static const danger = Color(0xFFF13932);
}

class AppBackground extends StatelessWidget {
  const AppBackground({super.key, required this.child, this.showStatus = true});

  final Widget child;
  final bool showStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: _AbstractBackground()),
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                if (showStatus) const _FakeStatusBar(),
                Expanded(child: child),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FakeStatusBar extends StatelessWidget {
  const _FakeStatusBar();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
      child: Row(
        children: [
          const Text(
            '9:41 AM',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          const Spacer(),
          Icon(Icons.signal_cellular_alt, color: Colors.white, size: 17),
          const SizedBox(width: 4),
          Icon(Icons.wifi, color: Colors.white, size: 16),
          const SizedBox(width: 4),
          Icon(Icons.battery_full, color: Colors.white, size: 20),
        ],
      ),
    );
  }
}

class _AbstractBackground extends StatelessWidget {
  const _AbstractBackground();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _AbstractBackgroundPainter(),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF3F58FF), Color(0xFF05044D), Color(0xFF001D8F)],
            stops: [0, .45, 1],
          ),
        ),
      ),
    );
  }
}

class _AbstractBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final glow = Paint()
      ..shader =
          RadialGradient(
            colors: [Colors.white.withOpacity(.20), Colors.transparent],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * .32, size.height * .16),
              radius: 190,
            ),
          );
    canvas.drawCircle(Offset(size.width * .32, size.height * .16), 190, glow);

    final light = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFFE4D4FF), Color(0xFF7259F0), Color(0x001D1464)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final left = Path()
      ..moveTo(0, size.height * .39)
      ..cubicTo(
        size.width * .28,
        size.height * .42,
        size.width * .36,
        size.height * .50,
        size.width * .55,
        size.height * .49,
      )
      ..cubicTo(
        size.width * .32,
        size.height * .63,
        size.width * .16,
        size.height * .72,
        0,
        size.height * .66,
      )
      ..close();
    canvas.drawPath(left, light);

    final right = Path()
      ..moveTo(size.width, size.height * .32)
      ..cubicTo(
        size.width * .54,
        size.height * .62,
        size.width * .49,
        size.height * .80,
        size.width * .52,
        size.height,
      )
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(right, light);

    final dark = Paint()..color = Colors.black.withOpacity(.55);
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * .53, size.height * .46),
        width: size.width * .75,
        height: size.height * .16,
      ),
      dark,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
    this.margin,
    this.radius = 12,
    this.color,
    this.borderColor,
  });

  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double radius;
  final Color? color;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Colors.white.withOpacity(.16),
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor ?? Colors.white.withOpacity(.20)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = AppColors.mint,
    this.textColor = Colors.black,
  });

  final String label;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 12,
          shadowColor: color.withOpacity(.45),
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }
}

class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.index,
    required this.onHome,
    required this.onInsight,
    required this.onCreate,
    required this.onReflection,
    required this.onCommunity,
  });

  final int index;
  final VoidCallback onHome;
  final VoidCallback onInsight;
  final VoidCallback onCreate;
  final VoidCallback onReflection;
  final VoidCallback onCommunity;

  @override
  Widget build(BuildContext context) {
    final items = [
      (Icons.check_circle_outline, onHome),
      (Icons.bar_chart_rounded, onInsight),
      (Icons.add, onCreate),
      (Icons.favorite_border, onReflection),
      (Icons.headphones_outlined, onCommunity),
    ];
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: const Color(0xFF5869D2).withOpacity(.78),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final selected = i == index;
          final icon = items[i].$1;
          final onTap = items[i].$2;
          if (i == 2) {
            return GestureDetector(
              onTap: onTap,
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.violet,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.25),
                      blurRadius: 14,
                      offset: const Offset(0, 7),
                    ),
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 30),
              ),
            );
          }
          return IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              color: selected ? Colors.white : Colors.white.withOpacity(.70),
              size: selected ? 31 : 27,
            ),
          );
        }),
      ),
    );
  }
}
