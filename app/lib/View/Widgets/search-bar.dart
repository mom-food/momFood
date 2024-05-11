import 'package:flutter/material.dart';
import 'package:app/themes/dark.dart';
import 'package:app/themes/light.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({Key? key}) : super(key: key);

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
          child: TextField(
            //color: isDarkMode ? DarkThemeData.dark.colorScheme.background : LightThemeData.light.colorScheme.background,
            //child: Padding(
             // padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //child: SearchBar(
                controller: _controller,
            decoration: InputDecoration(
              hintText: 'Search...',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // اضف الكلمة الحالية إلى تاريخ البحث
                  String query = _controller.text.trim();
                  if (query.isNotEmpty && !searchHistory.contains(query)) {
                    setState(() {
                      searchHistory.add(query);
                    });
                  }
                  // قم بالبحث عن العناصر هنا
                },
              ),
            ),
          ),
        ),
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
