import 'package:app/Model/meal_model.dart';
import 'package:app/ViewModel/meal_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

class MealDetailsScreen extends StatelessWidget {
  final String mealId;
  TextEditingController _controller = TextEditingController(text: '0');

  MealDetailsScreen({required this.mealId});

  @override
  Widget build(BuildContext context) {
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
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () {
                try {
                  context.go("/");
                } catch (e) {}
              })
        ],
      ),
      body: Consumer<MealViewModel>(builder: (context, viewModel, child) {
        var meal =
            viewModel.meals.firstWhere((element) => element.id == mealId);
        var item =
            viewModel.cartItems.firstWhereOrNull((m) => m.meal.id == mealId);
        if (item != null) {
          _controller.text = item.quantity.toString();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Image.network(meal.image, fit: BoxFit.cover), flex: 2),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: (meal.price*0.8).toString(), // Price part
                                style: GoogleFonts.ibmPlexSansArabic(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontSize: 24,
                                        color:
                                            Color(0xFFFF9500), // Orange color
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                              TextSpan(
                                text: '₪', // Shekel symbol
                                style: GoogleFonts.ibmPlexSansArabic(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        fontSize: 24,
                                        color: Colors.black, // Black color
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          meal.name,
                          style: GoogleFonts.ibmPlexSansArabic(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontSize: 24,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold,
                                  )),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      color: Colors.white.withOpacity(
                          0.8), // Light background for better readability
                      padding: EdgeInsets.all(8),
                      child: Text(
                        meal.description,
                        style: GoogleFonts.ibmPlexSansArabic(
                          textStyle:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 18,
                                    color: Colors.black87,
                                  ),
                        ),
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ...(item == null
                ? [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.addToCart(meal);
                        },
                        child: Text('أضف إلى السلة',
                            style: GoogleFonts.ibmPlexSansArabic(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontSize: 24,
                                    color: Colors
                                        .white, // Text color on button for contrast
                                  ),
                            )),
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(double.infinity, 50),
                          padding: EdgeInsets.all(18),
                          backgroundColor: Color(0xFFFCB34C),
                        ),
                      ),
                    )
                  ]
                : [
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Row(children: [
                        Expanded(
                            child: InkWell(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            bottomLeft: Radius.circular(30.0),
                          ),
                          onTap: () {
                            // Your onTap function here
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                bottomLeft: Radius.circular(30.0),
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                viewModel.increaseQuantity(meal);
                              },
                            ),
                          ),
                        )),
                        Expanded(
                            child: TextField(
                          keyboardType: TextInputType.number,
                          controller: _controller,
                          onChanged: (value) {
                            viewModel.setQuantity(meal, int.parse(value));
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'الكمية',
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                          ),
                        )),
                        Expanded(
                            child: InkWell(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            bottomRight: Radius.circular(30.0),
                          ),
                          onTap: () {
                            // Your onTap function here
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                viewModel.decreaseQuantity(meal);
                              },
                            ),
                          ),
                        )),
                      ]),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 16.0, right: 16.0),
                      // delete button
                      child: ElevatedButton(
                        onPressed: () {
                          viewModel.removeFromCart(meal);
                        },
                        child: Text('حذف من السلة',
                            style: GoogleFonts.ibmPlexSansArabic(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                            )),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    )
                  ]),
          ],
        );
      }),
    );
  }
}
