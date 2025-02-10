import 'package:flutter/material.dart';

import '../screens/home/home_screen.dart';
import '../screens/search/search_screen.dart';
import 'home_bottom_navigation.dart';

ValueNotifier<int> navigationNotifier = ValueNotifier(0);

class HomeMainView extends StatelessWidget {
  HomeMainView({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    Center(child: Text('Profile screen')),
    Center(child: Text('Settings screen')),
  ];

  List<PreferredSizeWidget> _appBars(BuildContext context) => [
        _buildHomeAppBar(context),
        _buildProfileAppBar(),
        _buildSettingsAppBar(),
      ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: navigationNotifier,
        builder: (ctx, index, child) {
          return Scaffold(
            appBar: _appBars(context)[index],
            body: Stack(
              children: [
                _screens[index],
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: HomeBottomNavigation(),
                )
              ],
            ),
          );
        });
  }
}

_buildHomeAppBar(BuildContext context) {
  return AppBar(
    title: Text('Discover', style: TextStyle(fontWeight: FontWeight.bold)),
    actions: [
      IconButton(
        icon: Icon(Icons.search, size: 28),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SearchScreen()),
          );
        },
      ),
    ],
  );
}

_buildProfileAppBar() {
  return AppBar(
    title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
  );
}

_buildSettingsAppBar() {
  return AppBar(
    title: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
  );
}
