import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Model/search-model.dart';

class HomeTap extends StatelessWidget {
  const HomeTap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Consumer<MomFood>(
      // momFood: Model
      // child: to avoid expensive computations
        builder: (context, momFood, child) {
          return GridView.count(
            children: momFood.categories.map((category) {
              return Container(
                child: Column(children: [
                  Container(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(category.image, fit: BoxFit.cover),
                    ),
                    clipBehavior: Clip.hardEdge,
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  ),
                  Text(category.name),
                  Text(
                    "${category.price}\$",
                    //Strikethrough
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  Text("${category.price * ((100 - category.offer) / 100)}\$"),
                  Text("${category.offer}%"),
                ]),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(color: Colors.orange, width: 1),
                ),
                alignment: Alignment.center,
              );
            }).toList(),
            crossAxisCount: 3,
            crossAxisSpacing: 30,
            padding: const EdgeInsets.all(30),
            mainAxisSpacing: 30,
            childAspectRatio: 1 / 3,
          );
        })));
  }
}
