import 'package:app/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/ViewModel/meal_view_model.dart';

class OrderHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'سجل الطلبات',
          style: GoogleFonts.ibmPlexSansArabic(
            textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontSize: 24,
               color: AppColors.primary1,
                ),
          ),
        ),
      ),
      body: Directionality(
              textDirection: TextDirection.rtl,

        child: Consumer<MealViewModel>(
          builder: (context, mealViewModel, child) {
            return ListView.builder(
              itemCount: mealViewModel.orderHistory.length,
              itemBuilder: (context, index) {
                final order = mealViewModel.orderHistory[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      'الطلب ${index + 1}',
                      style: GoogleFonts.ibmPlexSansArabic(
                        textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontSize: 20,
                              color: AppColors.primary1,
                            ),
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...order.items.map((item) => Text(
                              '${item.quantity} x ${item.meal.name}',
                              style: GoogleFonts.ibmPlexSansArabic(
                                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                              ),
                            )),
                        Text(
                          'السعر الكلي: ${order.totalPrice} ₪',
                          style: GoogleFonts.ibmPlexSansArabic(
                            textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
