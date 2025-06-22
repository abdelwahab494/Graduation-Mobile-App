import 'package:flutter/material.dart';
import 'package:grad_project/screens/home/home.dart';
import 'package:grad_project/screens/home/notifications.dart';
import 'package:grad_project/screens/home/profile.dart';
import 'package:grad_project/screens/home/reports.dart';
import 'package:grad_project/core/colors.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      Home(onNavigate: _onItemTapped),
      // Home2(),
      Reports(),
      Notifications(),
      Profile(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.backGround,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: AppColors.backGround,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: Colors.grey,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 0
                      ? Icon(Icons.home)
                      : Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 1
                      ? Icon(Icons.assignment)
                      : Icon(Icons.assignment_outlined),
              label: 'Reports',
            ),
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 2
                      ? Icon(Icons.notifications)
                      : Icon(Icons.notifications_outlined),
              label: 'Notification',
            ),
            BottomNavigationBarItem(
              icon:
                  _selectedIndex == 3
                      ? Icon(Icons.person)
                      : Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
