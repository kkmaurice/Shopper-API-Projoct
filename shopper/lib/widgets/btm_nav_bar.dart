import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:shopper/screens/home/home.dart';
import 'package:shopper/screens/settings/settings.dart';

import '../screens/cart/cart_screen.dart';
import '../screens/categories/categories.dart';
import 'package:badges/badges.dart' as badges;

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
    const Cart(),
    const Settings()
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
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.blue,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              CarbonIcons.home,
            ),
            label: 'Home',
            backgroundColor: Color(0xff40c4ff),
          ),
          const BottomNavigationBarItem(
              icon: Icon(
                CarbonIcons.categories,
              ),
              label: 'Categories',
              backgroundColor: Color(0xff40c4ff)),
          BottomNavigationBarItem(
            // icon: Icon(
            //   CarbonIcons.shopping_cart,
            // ),
            icon: badges.Badge(
              badgeStyle: badges.BadgeStyle(
                padding: const EdgeInsets.all(5),
                borderRadius: BorderRadius.circular(10),
                badgeColor: Colors.redAccent,
                elevation: 1,
              ),
              //elevation: 1,
              //badgeColor: kBrandAccent,
              showBadge: true,
              //showBadge: cartProvider.cartItems.isNotEmpty,
              badgeContent: Text(
                //cartProvider.cartItems.length.toString(),
                2.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Icon(
                CarbonIcons.shopping_cart,
              ),
            ),
            label: 'Cart',
            backgroundColor: Color(0xff40c4ff),
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              CarbonIcons.settings,
            ),
            label: 'Settings',
            backgroundColor: Color(
              0xff40c4ff,
            ),
          ),
        ],
      ),
    );
  }
}
