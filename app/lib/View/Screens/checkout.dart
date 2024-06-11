import 'package:app/Model/meal_model.dart';
import 'package:app/ViewModel/meal_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
            color: Color(0xFFFEA11F),
            image: DecorationImage(
              image: AssetImage("assets/images/checkout.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                top: 40.0, left: 20.0, right: 20.0, bottom: 80.0),
            child: Column(
              children: [
                Text(
                  "الحساب",
                  style: GoogleFonts.ibmPlexSansArabic(
                    textStyle:
                    Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "عندما تكون الوجبة جاهزة سيتم التاصل مع حضرتكم",
                  style: GoogleFonts.ibmPlexSansArabic(
                    textStyle:
                    Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "السعر الكلي",
                        style: GoogleFonts.ibmPlexSansArabic(
                          textStyle:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontSize: 24,
                            color: Colors.white,
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
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                fontSize: 24,
                                color: Colors.white,
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
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          context.go("/successful_checkout");
                        },
                        child: Text(
                          'تأكيد الطلب',
                          style: GoogleFonts.ibmPlexSansArabic(
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                              fontSize: 16,
                              color: Colors.black, // Text color on button for contrast
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 24.0), // Adjust padding as needed
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0), // Adjust the radius as needed
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'إلغاء',
                          style: GoogleFonts.ibmPlexSansArabic(
                            textStyle: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                              fontSize: 16,
                              color: Colors
                                  .black54, // Text color on button for contrast
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 24.0), // Adjust padding as needed
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                16.0), // Adjust the radius as needed
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
          ),
        ),
      ),
    );
  }
}
