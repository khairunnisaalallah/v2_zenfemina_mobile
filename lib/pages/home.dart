import 'package:flutter/material.dart';
import 'package:zenfemina_v2/navigation/profile.dart';
import 'package:zenfemina_v2/navigation/pray.dart';
import 'package:zenfemina_v2/navigation/dashboard.dart';
import 'package:zenfemina_v2/navigation/article.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int _currentPageIndex = 0;

  final List<Widget> _pages = [
    DashboardPage(),
    ArticlePage(),
    PrayPage(),
    profilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPageIndex],
      bottomNavigationBar: SizedBox(
        height: 70, // Atur ketinggian yang diinginkan
        child: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _currentPageIndex = index;
            });
          },
          indicatorColor: Color(0xFFDA4256).withOpacity(0.1),
          selectedIndex: _currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded, color: Color(0xFFDA4256)),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.article_outlined),
              selectedIcon: Icon(Icons.article, color: Color(0xFFDA4256)),
              label: 'Article',
            ),
            NavigationDestination(
              icon: Icon(Icons.mosque_outlined),
              selectedIcon: Icon(Icons.mosque, color: Color(0xFFDA4256)),
              label: 'Pray',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline_rounded),
              selectedIcon:
                  Icon(Icons.person_rounded, color: Color(0xFFDA4256)),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
