import 'package:app/View/Screens/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import '../Widgets/mom_food_title.dart';
import '../Widgets/nav_bar.dart';
import 'OfferMeals.dart';


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
      appBar: MomFoodTitle(

      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                MealOfferScreen(),
                TemporaryCart(),
                // ProfileScreen(),
              ],
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
