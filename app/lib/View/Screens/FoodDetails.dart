import 'package:app/Services/mealDetailsServices.dart';
import 'package:flutter/material.dart';

import '../../Model/mealDetailsModel.dart';
import '../../colors.dart';
import 'Cart.dart';
class FoodDetailsPage extends StatelessWidget {
  final Cart cart;
  FoodDetailsPage(this.cart);
  @override
  Widget build(BuildContext context) {
    MealDetailsModel? meal ;
    MealDetailsServices mealDetailsServices = new MealDetailsServices();
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Order / Food Details', style: Theme.of(context).textTheme.headline6?.copyWith(
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
        future: mealDetailsServices.fetchMealDetails('662978ed6ea592baeb0652ba'),
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
                          Text(meal.price.toString(), style: Theme.of(context).textTheme.headline6?.copyWith(
                            fontSize: 24,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          )),
                          Text(meal.name, style: Theme.of(context).textTheme.headline5?.copyWith(
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
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
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
}