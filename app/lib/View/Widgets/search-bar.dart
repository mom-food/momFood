import 'package:app/ViewModel/meal_view_model.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:app/themes/dark.dart';
import 'package:app/themes/light.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const CustomSearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late SearchController _controller;
  bool isDarkMode = false;
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    _controller = SearchController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Consumer<MealViewModel>(builder: (context, momFood, child) {
          return TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  String query = _controller.text.trim();
                  momFood.search(query);
                },
              ),
            ),
          );
        })),
      ],
    );
  }
}

// Extension method to set the theme data
extension ThemeDataExtension on ThemeData {
  void setTheme(ThemeData themeData) {
    ThemeData? baseTheme = this.copyWith();

    // Set the brightness and color scheme of the theme
    baseTheme = baseTheme.copyWith(
      brightness: themeData.brightness,
      colorScheme: themeData.colorScheme,
    );

    // Apply the modified theme
  }
}
