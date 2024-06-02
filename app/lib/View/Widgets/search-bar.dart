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
  late TextEditingController _controller;
  bool isDarkMode = false;
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Container(
            width: 300,
            height: 36,
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: 300,
                    height: 36,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x11000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 36,
                          padding: const EdgeInsets.all(8),
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(-1.00, -0.00),
                              end: Alignment(1, 0),
                              colors: [Color(0xFFE8E8E8), Colors.white],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 28,
                                height: 28,
                                child: Icon(Icons.search, color: Color(0x993C3C43), size: 18),
                              ),
                              Expanded(
                                child: Consumer<MealViewModel>(
                                  builder: (context, momFood, child) {
                                    return TextField(
                                      controller: _controller,
                                      decoration: InputDecoration(
                                        hintText: 'البحث',
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                                        hintStyle: TextStyle(
                                          color: Color(0x993C3C43),
                                          fontSize: 12,
                                          fontFamily: 'Encode Sans',
                                          fontWeight: FontWeight.w400,
                                          height: 0.17,
                                        ),
                                      ),
                                      textAlign: TextAlign.right,
                                      onSubmitted: (query) {
                                        momFood.search(query);
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
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
  }
}
