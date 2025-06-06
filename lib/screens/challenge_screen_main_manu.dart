import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_application_2/screens/consumibles_screen.dart';
import 'package:flutter_application_2/screens/herramienta_screen.dart';
import 'challenge_screen.dart';

class ChallengeMainMenu extends StatefulWidget {
  const ChallengeMainMenu({super.key});

  @override
  State<ChallengeMainMenu> createState() => _ChallengeMainMenuState();
}

class _ChallengeMainMenuState extends State<ChallengeMainMenu> {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    const ChallengeScreen(showAppBar: true),
    const ToolsScreen(showAppBar: true),
    const ConsumiblesScreen(showAppBar: true),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF4B6F44).withOpacity(0.8),
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _screens,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
        ),
      ),
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.airplanemode_active, title: 'Modelos'),
          TabItem(icon: Icons.build, title: 'Herramientas'),
          TabItem(icon: Icons.palette, title: 'Consumibles'),
        ],
        initialActiveIndex: _currentIndex,
        onTap: (int index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: const Color.fromARGB(255, 13, 13, 56),
        style: TabStyle.react,
        activeColor: const Color.fromARGB(255, 7, 220, 228),
        color: Colors.white70,
        height: 55,
      ),
    );
  }
}