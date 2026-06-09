import 'dart:async';

import 'package:flutter/material.dart';

import '../MyHomePage.dart';
import '../data/app_models.dart';
import '../data/app_repository.dart';
import '../theme/app_design.dart';
import 'create_habit_flow.dart';
import 'insight_general_page.dart';
import 'reflection_page.dart';

class InsightPage extends StatefulWidget {
  const InsightPage({super.key});

  @override
  State<InsightPage> createState() => _InsightPageState();
}

class _InsightPageState extends State<InsightPage> {
  final PageController _controller = PageController(viewportFraction: .86);
  Timer? _timer;
  int _page = 0;
  int _itemCount = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_controller.hasClients || _itemCount < 2) return;
      final next = (_page + 1) % _itemCount;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

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
                  child: StreamBuilder<List<HealingContent>>(
                    stream: AppRepository().watchHealingContents(),
                    builder: (context, snapshot) {
                      final items = snapshot.data ?? const <HealingContent>[];
                      _itemCount = items.length;
                      if (items.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mint,
                          ),
                        );
                      }
                      return PageView.builder(
                        controller: _controller,
                        itemCount: items.length,
                        onPageChanged: (value) => setState(() => _page = value),
                        itemBuilder: (context, index) => _StoryCard(
                          index: '${index + 1}'.padLeft(2, '0'),
                          content: items[index],
                          onTap: () => _showContent(items[index]),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 26),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _itemCount,
                    (i) => Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: i == _page
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

  void _showContent(HealingContent content) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF171061),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              content.type == 'podcast' ? Icons.headphones : Icons.menu_book,
              color: AppColors.mint,
              size: 38,
            ),
            const SizedBox(height: 16),
            Text(
              content.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content.author,
              style: const TextStyle(color: AppColors.violet),
            ),
            const SizedBox(height: 12),
            Text(
              content.subtitle,
              style: const TextStyle(color: Colors.white, height: 1.4),
            ),
            const SizedBox(height: 18),
            Text(
              content.url,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  const _StoryCard({
    required this.index,
    required this.content,
    required this.onTap,
  });

  final String index;
  final HealingContent content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              height: 138,
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
              right: 13,
              bottom: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    content.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      height: 1.2,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(
                    '${content.type == 'podcast' ? 'Podcast' : 'Sách'} • ${content.subtitle}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(.82),
                      fontSize: 13,
                      height: 1.25,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
