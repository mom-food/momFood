import 'package:app/ViewModel/meal_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const CustomSearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Consumer<MealViewModel>(
            builder: (context, mealViewModel, child) {
              return TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      String query = _controller.text.trim();
                      mealViewModel.search(query);
                    },
                  ),
                ),
              );
            },
          ),
        ),
        IconButton(
          icon: Icon(isDarkMode ? Icons.brightness_2 : Icons.wb_sunny),
          onPressed: () {
            setState(() {
              isDarkMode = !isDarkMode;
              // Toggle theme functionality here if needed
            });
          },
        ),
      ],
    );
  }
}
