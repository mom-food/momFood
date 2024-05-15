import 'package:app/ViewModel/meal_view_mode.dart';
import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:app/themes/dark.dart';
import 'package:app/themes/light.dart';
import 'package:provider/provider.dart';
import '../../Model/search-model.dart';

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
        Expanded(child: Consumer2<MomFood, MealViewModel>(builder: (context, momFood, mealViewModel, child) {
          return TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  String query = _controller.text.trim();
                  // momFood.search(query);
                  mealViewModel.search(query);
                },
              ),
            ),
          );
        })),
        IconButton(
          icon: Icon(isDarkMode ? Icons.brightness_2 : Icons.wb_sunny),
          onPressed: () {
            setState(() {
              isDarkMode = !isDarkMode;
              if (isDarkMode) {
                //Theme.of(context).brightness = Brightness.dark;
              } else {
                //Theme.of(context).brightness = Brightness.light;
              }
            });
          },
        ),
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
