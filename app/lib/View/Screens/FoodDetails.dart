import 'package:app/Services/mealDetailsServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/mealDetailsModel.dart';
import '../../colors.dart';

import 'Cart.dart';
import '../../Model/Cart_ItemModel.dart';
import 'package:flutter/material.dart';
import '../../Model/mealDetailsModel.dart';
import '../../Services/mealDetailsServices.dart';
import '../../colors.dart';
import 'Cart.dart'; // Make sure this import is correct and Cart class/provider is properly implemented.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Services/mealDetailsServices.dart';

import '../../Model/mealDetailsModel.dart';

import '../../colors.dart'; // Assuming you have color definitions in this file.

class FoodDetailsPage extends StatelessWidget {
  final String mealId;

  const FoodDetailsPage({Key? key, required this.mealId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealDetailsServices = MealDetailsServices();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل الطعام',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: FutureBuilder<MealDetailsModel?>(
        future: mealDetailsServices.fetchMealDetails(mealId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null) {
            return const Center(child: Text('No data found'));
          } else {
            final meal = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (meal.imageUrl.isNotEmpty && Uri.tryParse(meal.imageUrl)?.hasAbsolutePath == true)
                    Image.network(
                      meal.imageUrl,
                      fit: BoxFit.cover,
                      height: 250,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.error, size: 250); // Placeholder for broken image
                      },
                    )
                  else
                    const Icon(Icons.broken_image, size: 250), // Fallback image
                  const SizedBox(height: 16),
                  Text(
                    meal.name,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "\$${meal.price.toStringAsFixed(2)}",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primary1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    meal.description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Provider.of<CartProvider>(context, listen: false).addItem(
                          CartItem(
                            id: meal.id,
                            name: meal.name,
                            price: meal.price,
                            imageUrl: meal.imageUrl,
                          ) as Cart,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('أضيف إلى السلة!'),
                          ),
                        );
                      },
                      child: const Text(
                        'أضف إلى السلة',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: AppColors.primary1,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}


class CartProvider with ChangeNotifier {
  List<Cart> _items = [];

  List<Cart> get items => _items;

  void addItem(Cart item) {
    _items.add(item);
    notifyListeners();
  }
}

/*class FoodDetailsPage extends StatelessWidget {

  final String mealId;
  FoodDetailsPage({required this.mealId});

  get cart => null;


  @override
  Widget build(BuildContext context) {
    MealDetailsModel? meal ;
    MealDetailsServices mealDetailsServices = new MealDetailsServices();
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Order / Food Details',  style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: 22,
          color: Colors.white, // Ensuring good contrast against the AppBar background
          fontWeight: FontWeight.bold,
        )),
        actions: [
          IconButton(icon: Icon(Icons.share), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
      ),
      body: FutureBuilder<MealDetailsModel?>(
        future: mealDetailsServices.fetchMealDetails(mealId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          } else {
            MealDetailsModel meal = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.network(meal.image, fit: BoxFit.cover),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(meal.price.toString(), style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          )),
                          Text(meal.name, style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          )),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        color: Colors.white.withOpacity(0.8), // Light background for better readability
                        padding: EdgeInsets.all(8),
                        child: Text(
                          meal.description,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            shadows: [
                              Shadow(
                                offset: Offset(1.0, 1.0),
                                blurRadius: 3.0,
                                color: Color.fromARGB(150, 0, 0, 0),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      cart.addItem(meal);
                      Navigator.pushNamed(context, '/cart');
                    },
                    child: Text('أضف إلى السلة', style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color on button for contrast
                    )),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50), backgroundColor: AppColors.primary1,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}*/