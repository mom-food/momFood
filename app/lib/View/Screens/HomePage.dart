import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../themes/theme-provider.dart';
import 'CategoryMeal.dart';
import 'OfferMeals.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final void Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'العربة',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'الملف الشخصي',
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: onItemTapped,
    );
  }
}

class MyAppBar1 extends StatelessWidget implements PreferredSizeWidget {
  final dynamic title;
  final bool isLightTheme;

  const MyAppBar1({
    Key? key,
    required this.title,
    required this.isLightTheme,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AppBar(
          title: _buildTitleWidget(),
          centerTitle: true,
          backgroundColor:
          themeProvider.isDarkMode ? Colors.black : Colors.white,
          automaticallyImplyLeading: true, // قم بتعيين هذا إلى true لإضافة زر العودة
          actions: [
            IconButton(
              icon: Icon(
                themeProvider.getThemeIcon(),
                color:
                themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTitleWidget() {
    if (title is String) {
      return Text(
        title,
      );
    } else if (title is Widget) {
      return title;
    } else {
      return Container();
    }
  }
}

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar1(
        title: 'My App',
        isLightTheme: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                MealOfferScreen(),
              ],
            ),
          ),
          SizedBox(height: 0),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(0), // ضبط الحشو الداخلي
              child: MealCategoryScreen(),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}