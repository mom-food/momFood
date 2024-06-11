import 'package:app/Model/meal_model.dart';
import 'package:app/View/Screens/checkout.dart';
import 'package:app/ViewModel/meal_view_model.dart';
import 'package:app/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Widgets/nav_bar.dart';
import 'Authentication/profile.dart';
import 'home_page.dart';

class CartShopping extends StatefulWidget {
  const CartShopping({super.key});

  @override
  State<CartShopping> createState() => _CartShoppingState();
}

class _CartShoppingState extends State<CartShopping> {
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePageScreen()),
        );
        break;
      case 1:
      break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
        );
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('عربة التسوق'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/'),
          ),
        ),
        body: Consumer<MealViewModel>(
          builder: (context, viewModel, child) {
            List<({Meal meal, int quantity})> filteredCartItems =
                viewModel.cartItems.where((item) => item.quantity > 0).toList();
            final double totalPrice = filteredCartItems.fold(
                0.0, (sum, item) => sum + (item.meal.price * item.quantity));

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredCartItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredCartItems[index];
                      return Container(
                        margin: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.28),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 88,
                              height: 88,
                              margin: const EdgeInsets.all(8.0),
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
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${item.meal.price.toStringAsFixed(2)} ₪',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.orange,
                                          ),
                                        ),
                                       /* Text(
                                            '${(item.meal.price * item.quantity).toStringAsFixed(2)} ₪'
                                        ),*/
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () =>viewModel.decreaseQuantity(item.meal),
                                              icon: const Icon(Icons.remove),
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              '${item.quantity}',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () => viewModel.increaseQuantity(item.meal),
                                              icon: const Icon(Icons.add),
                                              color: Colors.grey,
                                            ),
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
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
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
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(296, 53),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 86, vertical: 15),
                      backgroundColor: AppColors.primary1,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'اطلب الآن!',
                      style: GoogleFonts.ibmPlexSansArabic(
                        textStyle:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      viewModel.removeAllCartItems();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(296, 53),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 86, vertical: 15),
                      backgroundColor: AppColors.backgroundColorLight,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'حذف محتويات السلة',
                      style: GoogleFonts.ibmPlexSansArabic(
                        textStyle:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontSize: 19,
                                  color: AppColors.primary1,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        bottomNavigationBar: CustomBottomNavBar(
          selectedIndex: _selectedIndex,
          onItemTapped: _onItemTapped,
        ),
      ),
    );
  }
}
