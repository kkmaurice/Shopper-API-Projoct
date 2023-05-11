import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:shopper/screens/home/home.dart';

import '../screens/categories/categories.dart';
import 'cart_icon.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _DefaultHomePageState();
}

class _DefaultHomePageState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Home(),
    const CategoryScreen(),
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.indigo,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5.0,
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              CarbonIcons.home,
            ),
            label: 'Home',
            backgroundColor: Color(0xff40c4ff),
          ),
          BottomNavigationBarItem(
              icon: Icon(
                CarbonIcons.categories,
              ),
              label: 'Categories',
              backgroundColor: Color(0xff40c4ff)),
          BottomNavigationBarItem(
            //icon: ShoppingCartIcon(),
            icon: ShoppingCartIcon(),
            label: 'Cart',
            backgroundColor: Color(0xff40c4ff),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CarbonIcons.user,
            ),
            label: 'Profile',
            backgroundColor: Color(
              0xff40c4ff,
            ),
          ),
        ],
      ),
    );
  }
}
