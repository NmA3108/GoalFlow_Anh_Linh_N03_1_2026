import 'package:flutter/material.dart';
import '../MyHomePage.dart';
import 'MyContactPage.dart';
import '../pages/content_page.dart';
import '../pages/about_page.dart';

class BotNavi extends StatefulWidget {
  @override
  _BotNaviState createState() => _BotNaviState();
}

class _BotNaviState extends State<BotNavi> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MyHomePage(),
    ContentPage(),
    MyContactPage(),
    AboutPage(),
  ];

  void _onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: Container(
        height: 75,
        decoration: BoxDecoration(
          color: const Color(0xFF1B1464),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            _buildNavItem(Icons.home, "Home", 0),
            _buildNavItem(Icons.article_outlined, "Content", 1),
            // _buildNavItem(Icons.contact_mail, "Contact", 2),
            _buildNavItem(Icons.info_outline, "About", 3),
          ],
        ),
      ),
    );
  }

  // 🔥 NAV ITEM XỊN (InkWell + hover + ripple)
  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _onTapped(index),
          borderRadius: BorderRadius.circular(16),

          // Hover effect (web)
          hoverColor: Colors.white.withOpacity(0.05),

          // Ripple click effect
          splashColor: Colors.purpleAccent.withOpacity(0.2),

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedScale(
                  scale: isSelected ? 1.1 : 1.0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    icon,
                    color:
                        isSelected ? Colors.purpleAccent : Colors.white38,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    color:
                        isSelected ? Colors.purpleAccent : Colors.white38,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}