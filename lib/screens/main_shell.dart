import 'package:flutter/material.dart';
import '../services/studio_storage.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';
import 'modular_kitchen_screen.dart';
import 'wardrobe_screen.dart';
import 'living_room_screen.dart';
import 'projects_screen.dart';
import 'about_us_screen.dart';
import 'contact_us_screen.dart';
import 'quote_screen.dart';

class MainShell extends StatefulWidget {
  final StudioConfig config;
  const MainShell({super.key, required this.config});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedIndex = 0;

  void _onNavigate(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(config: widget.config, onNavigate: _onNavigate),
      ModularKitchenScreen(config: widget.config, onNavigate: _onNavigate),
      WardrobeScreen(config: widget.config, onNavigate: _onNavigate),
      LivingRoomScreen(config: widget.config, onNavigate: _onNavigate),
      ProjectsScreen(config: widget.config, onNavigate: _onNavigate),
      AboutUsScreen(config: widget.config, onNavigate: _onNavigate),
      ContactUsScreen(config: widget.config),
      QuoteScreen(config: widget.config),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppTheme.goldBorder, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex > 4 ? 0 : _selectedIndex,
          onTap: _onNavigate,
          backgroundColor: AppTheme.charcoalCard,
          selectedItemColor: AppTheme.champagneGold,
          unselectedItemColor: AppTheme.mutedSilver,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 11,
          unselectedFontSize: 10,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.kitchen_outlined), activeIcon: Icon(Icons.kitchen), label: 'Kitchen'),
            BottomNavigationBarItem(icon: Icon(Icons.door_sliding_outlined), activeIcon: Icon(Icons.door_sliding), label: 'Wardrobe'),
            BottomNavigationBarItem(icon: Icon(Icons.weekend_outlined), activeIcon: Icon(Icons.weekend), label: 'Living'),
            BottomNavigationBarItem(icon: Icon(Icons.photo_library_outlined), activeIcon: Icon(Icons.photo_library), label: 'Projects'),
          ],
        ),
      ),
    );
  }
}
