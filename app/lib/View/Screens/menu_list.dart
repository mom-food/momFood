import 'package:app/View/Screens/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../Model/meal_model.dart';
import '../../Services/meal_services.dart';
import '../Widgets/Button/back_button.dart';
import '../Widgets/cards/meal_card.dart';
import '../Widgets/nav_bar.dart';
import 'Authentication/profile.dart';
import 'home_page.dart';

class MealList extends StatelessWidget {
  final String categoryId;

  const MealList({Key? key, required this.categoryId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:CustomBackButton(),
      ),
      body: FutureBuilder<List<Meal>>(
        future: fetchMealsByCategory(categoryId),
        builder: (context, snapshot) {
          return _buildContent(context, snapshot);
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 0,
        onItemTapped: (index) => _handleNavigation(context, index),
      ),
    );
  }

  Widget _buildContent(BuildContext context, AsyncSnapshot<List<Meal>> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.waiting:
        return const Center(child: CircularProgressIndicator());
      case ConnectionState.done:
        if (snapshot.hasError) {
          return Center(child: Text('Error loading data: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No meals found.'));
        } else {
          final meals = snapshot.data!;
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20.0,
              crossAxisSpacing: 40.0,
              childAspectRatio: 0.7,
            ),
            padding: const EdgeInsets.all(35.0),
            itemCount: meals.length,
            itemBuilder: (context, index) {
              final meal = meals[index];
              return MealCard(
                meal: meal,
                onTap: () => context.go("/mealDetailsScreen/${meal.id}"),
              );
            },
          );
        }
      default:
        return Container();
    }
  }

  void _handleNavigation(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePageScreen()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartShopping()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }
}
