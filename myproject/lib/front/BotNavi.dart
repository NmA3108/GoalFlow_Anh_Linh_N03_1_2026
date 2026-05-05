import 'package:flutter/material.dart';
import 'MyHomePage.dart';
import 'MyContactPage.dart';

class BotNavi extends StatefulWidget {
  @override
  _BotNaviState createState() => _BotNaviState();
}

class _BotNaviState extends State<BotNavi> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    MyHomePage(),
    MyContactPage(),
    Center(child: Text("Profile Page")), // page thứ 3 (có thể đổi sau)
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: "Contact",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}