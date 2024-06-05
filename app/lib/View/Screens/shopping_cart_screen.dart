import 'package:app/Model/meal_model.dart';
import 'package:app/View/Screens/Checkout.dart';
import 'package:app/ViewModel/meal_view_model.dart';
import 'package:app/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class TemporaryCart extends StatelessWidget {
  const TemporaryCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('عربة التسوق'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
        ),
        body: Consumer<MealViewModel>(builder: (context, viewModel, child) {
          List<({Meal meal, int quantity})> filteredCartItems =
              viewModel.cartItems.where((item) => item.quantity > 0).toList();
          final double totalPrice = filteredCartItems.fold(
              0.0, (a, b) => a + (b.meal.price * b.quantity));
          return Column(
            children: [
              Expanded(
                flex: 1,
                child: ListView.builder(
                  itemCount: filteredCartItems.length,
                  itemBuilder: (context, index) {
                    final item = filteredCartItems.elementAt(index);
                    return Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7.28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 88,
                                height: 88,
                                margin: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.28),
                                  image: DecorationImage(
                                    image: NetworkImage(item.meal.image),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        item.meal.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${item.meal.price.toStringAsFixed(2)} ₪',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${item.meal.price * item.quantity}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(4.0),
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CheckoutScreen(
                          totalPrice: totalPrice,
                          items: filteredCartItems,
                        );
                      },
                    );
                  },
                  child: Text(
                    'اطلب الآن!',
                    style: GoogleFonts.ibmPlexSansArabic(
                      textStyle:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 19,
                                color: Colors.white,
                            fontWeight: FontWeight.w700,
                            height: 0.06,
                              ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(296, 53),
                    padding: const EdgeInsets.symmetric(horizontal: 86, vertical: 15),
                    backgroundColor: AppColors.primary1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                    viewModel.removeAllCartItems();
                  },
                  child: Text(
                    'حذف محتويات السلة',
                    style: GoogleFonts.ibmPlexSansArabic(
                      textStyle:
                      Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 19,
                        color: AppColors.primary1,
                        fontWeight: FontWeight.w700,
                        height: 0.06,
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(296, 53),
                    padding: const EdgeInsets.symmetric(horizontal: 86, vertical: 15),
                    backgroundColor: AppColors.backgroundColorLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
