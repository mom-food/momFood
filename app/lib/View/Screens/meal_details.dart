import 'package:app/Model/meal_model.dart';
import 'package:app/View/Screens/splash_screen.dart';
import 'package:app/ViewModel/meal_view_model.dart';
import 'package:app/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';
import '../../Services/user_services.dart';
import '../Widgets/dialog/login_dialog.dart';
import '../Widgets/nav_bar.dart';
import 'home_page.dart';
import 'shopping_cart_screen.dart';


class MealDetailsScreen extends StatefulWidget {
  final String mealId;
  MealDetailsScreen({required this.mealId});

  @override
  _MealDetailsScreenState createState() => _MealDetailsScreenState();
}

class _MealDetailsScreenState extends State<MealDetailsScreen> {
  TextEditingController _controller = TextEditingController(text: '0');
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => TemporaryCart()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'تفاصيل الطعام',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontSize: 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Consumer<MealViewModel>(builder: (context, viewModel, child) {
        var meal =
        viewModel.meals.firstWhere((element) => element.id == widget.mealId);
        var item =
        viewModel.cartItems.firstWhereOrNull((m) => m.meal.id == widget.mealId);
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
                                text:
                                (meal.price * 0.8).toString(),
                                style: GoogleFonts.ibmPlexSansArabic(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                    fontSize: 24,
                                    color:
                                    Color(0xFFFF9500),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: '₪',
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
                          0.8),
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
                    if (UserServices.isSignedIn()) {
                      viewModel.addToCart(meal);
                    } else {
                      showLoginDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    padding: const EdgeInsets.all(18),
                    backgroundColor: const Color(0xFFFCB34C),
                  ),
                  child: Text(
                    'أضف إلى السلة',
                    style: GoogleFonts.ibmPlexSansArabic(
                      textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 24,
                        color: Colors.white,
                      ),
                    ),
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
                            color: AppColors.primary2,
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
                            color: AppColors.primary1,
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
                          color: AppColors.textColor1,
                        ),
                      )),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 86, vertical: 15),
                    backgroundColor: AppColors.backgroundColorLight,
                  ),
                ),
              )
            ]),
          ],
        );
      }),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
