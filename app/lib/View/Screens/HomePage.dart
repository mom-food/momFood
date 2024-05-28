import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/meal_view_model.dart';
import '../../Model/meal_model.dart';
import '../Widgets/search-bar.dart';
import 'package:app/View/Screens/shopping_cart_screen.dart';
import '../../themes/theme-provider.dart';
import 'CategoryMeal.dart';
import 'OfferMeals.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mom FOod'),
      ),
      body: Column(
        children: [
          CustomSearchBar(onSearch: (query) {
            Provider.of<MealViewModel>(context, listen: false).search(query);
          }),
          Expanded(
            child: Consumer<MealViewModel>(
              builder: (context, mealViewModel, child) {
                if (mealViewModel.meals.isEmpty) {
                  return Center(
                    child: Text('No meals found.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: mealViewModel.meals.length,
                    itemBuilder: (context, index) {
                      Meal meal = mealViewModel.meals[index];
                      return ListTile(
                        title: Text(meal.name),
                        subtitle: Text(meal.description),
                        leading: Image.network(meal.image),
                        trailing: Text('\$${meal.price.toString()}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

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
          automaticallyImplyLeading: true,
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
        title: 'Mom FOod',
        isLightTheme: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                MealOfferScreen(),
                TemporaryCart(),
                Text(" "),
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
