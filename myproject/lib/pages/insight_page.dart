import 'package:flutter/material.dart';

import '../MyHomePage.dart';
import '../theme/app_design.dart';
import 'create_habit_flow.dart';
import 'insight_general_page.dart';
import 'reflection_page.dart';

class InsightPage extends StatelessWidget {
  const InsightPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 26),
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Sự Thấu Hiểu',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 29,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.grid_view_rounded,
                      color: Colors.white.withOpacity(.95),
                      size: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 104),
                SizedBox(
                  height: 398,
                  child: PageView(
                    controller: PageController(viewportFraction: .86),
                    children: const [
                      _StoryCard(
                        index: '01',
                        title: 'Thói quen nhỏ',
                        subtitle: 'Vì sao dễ tốt hơn khó',
                      ),
                      _StoryCard(
                        index: '02',
                        title: 'Tiny steps',
                        subtitle: 'Why easy wins',
                      ),
                      _StoryCard(
                        index: '03',
                        title: 'Giữ nhịp',
                        subtitle: 'Tạo chuỗi mỗi ngày',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    6,
                    (i) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: i == 0
                            ? AppColors.violet
                            : Colors.white.withOpacity(.75),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppBottomNav(
            index: 4,
            onHome: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const MyHomePage()),
              (route) => false,
            ),
            onInsight: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const InsightGeneralPage()),
            ),
            onCreate: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CreateHabitFlowPage()),
            ),
            onReflection: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ReflectionPage()),
            ),
            onCommunity: () {},
          ),
        ],
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  final String index;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 18),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _LandscapePainter())),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 110,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(.10),
                    const Color(0xFF6F701A).withOpacity(.78),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            left: 13,
            child: Text(
              index,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Positioned(
            left: 13,
            bottom: 38,
            right: 13,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Positioned(
            left: 13,
            bottom: 16,
            right: 13,
            child: Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(.78),
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LandscapePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final sky = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFF798AA0), Color(0xFFFFD188), Color(0xFF857A2D)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, sky);

    final sun = Paint()
      ..shader =
          RadialGradient(
            colors: [Colors.white.withOpacity(.85), Colors.transparent],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * .20, size.height * .20),
              radius: 120,
            ),
          );
    canvas.drawCircle(Offset(size.width * .2, size.height * .2), 120, sun);

    final far = Paint()..color = const Color(0xFF5A5F5F).withOpacity(.75);
    final farPath = Path()
      ..moveTo(0, size.height * .48)
      ..lineTo(size.width * .22, size.height * .38)
      ..lineTo(size.width * .48, size.height * .50)
      ..lineTo(size.width * .75, size.height * .35)
      ..lineTo(size.width, size.height * .45)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(farPath, far);

    final hill = Paint()
      ..shader =
          const LinearGradient(
            colors: [Color(0xFFDEC36D), Color(0xFF4C752E)],
          ).createShader(
            Rect.fromLTWH(0, size.height * .46, size.width, size.height * .54),
          );
    final path = Path()
      ..moveTo(0, size.height * .66)
      ..cubicTo(
        size.width * .25,
        size.height * .54,
        size.width * .55,
        size.height * .77,
        size.width,
        size.height * .58,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, hill);

    final river = Paint()..color = const Color(0xFFDCE7EE).withOpacity(.75);
    final riverPath = Path()
      ..moveTo(size.width * .45, size.height)
      ..cubicTo(
        size.width * .55,
        size.height * .78,
        size.width * .20,
        size.height * .75,
        size.width * .36,
        size.height * .62,
      )
      ..cubicTo(
        size.width * .50,
        size.height * .52,
        size.width * .72,
        size.height * .62,
        size.width * .88,
        size.height * .43,
      );
    canvas.drawPath(
      riverPath,
      river
        ..strokeWidth = 9
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
