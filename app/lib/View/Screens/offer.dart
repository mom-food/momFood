import 'package:flutter/material.dart';
import '../../Model/offer-model.dart';
import '../../ViewModel/meal_view_mode.dart';
import '../Widgets/cards/offer-card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MealCategoryScreen extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MealCategoryScreen> {
  late Future<List<Meal>> _mealsFuture;

  @override
  void initState() {
    super.initState();
    _mealsFuture = MealViewModel().fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'العروضات',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
            child: FutureBuilder<List<Meal>>(
              future: _mealsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text('لا توجد بيانات'),
                  );
                } else {
                  return Column(
                    children: snapshot.data!.map((offer) {
                      double disPrice = offer.price * 0.8;
                      return MealOfferCard(
                        title: offer.name,
                        originalPrice: offer.price.toString(),
                        discountedPrice: disPrice,
                        imagePath: offer.imagePath.toString(),
                      );
                    }).toList(),
                  );
                }
              },
            ),
           ),
        );
    }
}