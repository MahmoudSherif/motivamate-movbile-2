import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quote_provider.dart';
import '../widgets/space_background.dart';
import '../widgets/quote_bar.dart';
import 'calendar/calendar_screen.dart';
import 'tasks/tasks_screen.dart';
import 'notes/notes_screen.dart';
import 'profile/profile_screen.dart';
import 'achieve/achieve_screen.dart';
import 'inspiration/inspiration_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const CalendarScreen(),
    const TasksScreen(),
    const NotesScreen(),
    const ProfileScreen(),
    const AchieveScreen(),
    const InspirationScreen(),
  ];

  final List<BottomNavigationBarItem> _navItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_today),
      label: 'Calendar',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.task_alt),
      label: 'Tasks',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.note),
      label: 'Notes',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Profile',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.emoji_events),
      label: 'Achieve',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.lightbulb),
      label: 'Inspire',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Start quote rotation when the main screen is loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuoteProvider>().startQuoteRotation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SpaceBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            // Main content
            Expanded(
              child: _screens[_selectedIndex],
            ),
            // Quote bar
            const QuoteBar(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border(
              top: BorderSide(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
          ),
          child: BottomNavigationBar(
            items: _navItems,
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            elevation: 0,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Colors.white.withOpacity(0.6),
            selectedFontSize: 12,
            unselectedFontSize: 11,
            iconSize: 24,
          ),
        ),
      ),
    );
  }
}