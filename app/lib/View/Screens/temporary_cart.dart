import 'package:app/Model/meal_model.dart';
import 'package:app/View/Screens/Checkout.dart';
import 'package:app/ViewModel/meal_view_model.dart';
import 'package:flutter/material.dart';
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
          title: Text('عربة التسوق المؤقتة'),
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
                    return ListTile(
                      subtitle: Text(
                          '${item.meal.name}:\n${item.meal.price} x ${item.quantity} = ${item.meal.price * item.quantity}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                   /* showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return CheckoutScreen(
                          totalPrice: totalPrice,
                          items: filteredCartItems,
                        );
                      },
                    );*/
                  },
                  child: Text(
                    'اطلب الآن!',
                    style: GoogleFonts.ibmPlexSansArabic(
                      textStyle:
                      Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 24,
                        color: Colors
                            .white, // Text color on button for contrast
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    padding: EdgeInsets.all(18),
                    backgroundColor: Color(0xFFFCB34C),
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
                        fontSize: 24,
                        color: Colors
                            .white, // Text color on button for contrast
                      ),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 50),
                      padding: EdgeInsets.all(18),
                      backgroundColor: Colors.red),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
