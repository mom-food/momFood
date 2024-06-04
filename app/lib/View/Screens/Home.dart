import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ViewModel/meal_view_model.dart';
import '../../Model/meal-model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: [
          CustomSearchBar(onSearch: (query) {
            Provider.of<MealViewModel>(context, listen: false).search(query);
          }),
          Expanded(
            child: Consumer<MealViewModel>(
              builder: (context, mealViewModel, child) {
                if (mealViewModel.meals.isEmpty) {
                  return Center(
                    child: Text('No meals found.'),
                  );
                } else {
                  return ListView.builder(
                    itemCount: mealViewModel.meals.length,
                    itemBuilder: (context, index) {
                      Meal meal = mealViewModel.meals[index];
                      return ListTile(
                        title: Text(meal.name),
                        subtitle: Text(meal.description),
                        leading: Image.network(meal.image),
                        trailing: Text('\$${meal.price.toString()}'),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const CustomSearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search for meals...',
          suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              String query = _controller.text.trim();
              widget.onSearch(query);
            },
          ),
        ),
      ),
    );
  }
}
