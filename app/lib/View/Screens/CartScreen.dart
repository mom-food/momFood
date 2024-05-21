// import 'package:flutter/material.dart';
// import 'package:app/Model/mealDetailsModel.dart';
// import 'Cart.dart';
//
// class CartScreen extends StatelessWidget {
//   final Cart cart;
//
//   CartScreen(this.cart);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Cart'),
//       ),
//       body: ListView.builder(
//         itemCount: cartItems.length,
//         itemBuilder: (context, index) {
//           MealDetailsModel item = cartItems[index];
//           return ListTile(
//             title: Text(item.name),
//             subtitle: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Price: ${item.price}'),
//                 Text('Description: ${item.description}'),
//               ],
//             ),
//             leading: Image.network(item.image),
//           );
//         },
//       ),
//     );
//   }
// }
