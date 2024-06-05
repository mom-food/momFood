import 'package:flutter/material.dart';
import '../../Screens/shopping_cart_screen.dart';

class CartTap extends StatelessWidget {
  const CartTap({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Cart(),
      ),
    );
  }
}
