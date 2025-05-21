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

  final List<Widget> _screens = [
    const ChallengeScreen(showAppBar: true), // Modificado
    const ToolsScreen(showAppBar: true),     // Modificado
    const ConsumiblesScreen(showAppBar: true),    // Modificado
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Se elimina el AppBar principal aquí
      body: _screens[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        items: const [
          TabItem(icon: Icons.airplanemode_active, title: 'Modelos'),
          TabItem(icon: Icons.build, title: 'Herramientas'),
          TabItem(icon: Icons.palette, title: 'Pintura, pegamento y más'),
          //TabItem(icon: Icons.adhesive, title: 'Cementos'),
        ],
        initialActiveIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        backgroundColor: Colors.blue,
        style: TabStyle.react, // Cambiado a react para 4 ítems
        activeColor: Colors.white,
        color: Colors.white70,
      ),
    );
  }
}