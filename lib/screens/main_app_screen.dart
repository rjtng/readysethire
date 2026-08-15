import 'package:flutter/material.dart';
import 'package:readysethire/screens/placeholders/feedback_screen.dart' show FeedbackScreen;
import 'package:readysethire/widgets/gradient_background.dart';
import 'package:readysethire/screens/home/new_home_screen.dart';
import 'package:readysethire/screens/features/powerful_features_screen.dart';
import 'package:readysethire/screens/placeholders/tools_screen.dart';     // Placeholder
import 'package:readysethire/screens/placeholders/unlock_screen.dart';    // Placeholder


class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const NewHomeScreen(),
    const PowerfulFeaturesScreen(),
    const ToolsScreen(),
    const WhoItIsForPage(),
    const FeedbackScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _widgetOptions,
        ),
        bottomNavigationBar: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.work_outline), label: 'Features'),
              BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Tools'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.lock_open_outlined), label: 'Unlock'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline), label: 'About'),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}