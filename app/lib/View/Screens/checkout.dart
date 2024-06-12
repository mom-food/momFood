import 'package:app/Model/meal_model.dart';
import 'package:app/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/ViewModel/meal_view_model.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatelessWidget {
  final double totalPrice;
  final List<({Meal meal, int quantity})> items;

  const CheckoutScreen({super.key, required this.totalPrice, required this.items});

  @override
  Widget build(BuildContext context) {
    return Consumer<MealViewModel>(
      builder: (context, mealViewModel, child) => Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: 400,
          alignment: Alignment.topRight,
          decoration: const BoxDecoration(
            color:  AppColors.primary1,
            image: DecorationImage(
              image: AssetImage("assets/images/checkout.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 40.0, left: 20.0, right: 20.0, bottom: 80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الحساب",
                  style: GoogleFonts.ibmPlexSansArabic(
                    textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 24,
                      color:  AppColors.textColor2,
                    ),
                  ),
                ),
                Text(
                  "عندما تكون الوجبة جاهزة سيتم التاصل مع حضرتكم",
                  style: GoogleFonts.ibmPlexSansArabic(
                    textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 20,
                      color:  AppColors.textColor2,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "السعر الكلي",
                        style: GoogleFonts.ibmPlexSansArabic(
                          textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: 24,
                            color: AppColors.textColor2,
                          ),
                        ),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '$totalPrice',
                            style: GoogleFonts.ibmPlexSansArabic(
                              textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 24,
                                color:  AppColors.textColor2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: '₪',
                            style: GoogleFonts.ibmPlexSansArabic(
                              textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: 24,
                                color: AppColors.textColor1,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          confirmOrder(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  AppColors.textColor2,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: Text(
                          'تأكيد الطلب',
                          style: GoogleFonts.ibmPlexSansArabic(
                            textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 24.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                        ),
                        child: Text(
                          'إلغاء',
                          style: GoogleFonts.ibmPlexSansArabic(
                            textStyle: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontSize: 16,
                              color:  AppColors.textColor1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void confirmOrder(BuildContext context) {
    final mealViewModel = Provider.of<MealViewModel>(context, listen: false);
    mealViewModel.addOrder(totalPrice, items);

    context.go("/successful_checkout");
  }
}