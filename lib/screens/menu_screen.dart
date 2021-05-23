import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:openrlg_mobile/screens/account_screen.dart';
import 'package:openrlg_mobile/screens/blogs_screen.dart';
import 'package:openrlg_mobile/screens/rdv_screen.dart';
import 'package:openrlg_mobile/utililities/constants.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  PageController _pageController = PageController();
  List<Widget> _screens = [ RdvScreen(),AccountScreen()];
  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: _onPageChanged,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.wysiwyg_rounded,
                color: _selectedIndex == 0 ? kPrimaryColor : Colors.grey,
              ),
              title: Text(
                'MES RENDEZ-VOUS',
                style: TextStyle(
                  color: _selectedIndex == 0 ? kPrimaryColor : Colors.grey,
                ),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _selectedIndex == 1 ? kPrimaryColor : Colors.grey,
              ),
              title: Text(
                'MON COMPTE',
                style: TextStyle(
                  color: _selectedIndex == 1 ? kPrimaryColor : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
