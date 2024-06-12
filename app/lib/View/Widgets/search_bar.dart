import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app/ViewModel/meal_view_model.dart';

import '../../colors.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onSearch;

  const CustomSearchBar({super.key, required this.onSearch});

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  late TextEditingController _controller;
  List<String> searchHistory = [];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _loadSearchHistory();
  }

  Future<void> _loadSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      searchHistory = prefs.getStringList('search_history') ?? [];
    });
  }

  Future<void> _saveSearchQuery(String query) async {
    final prefs = await SharedPreferences.getInstance();
    searchHistory.add(query);
    await prefs.setStringList('search_history', searchHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // Show search history list
              _showSearchHistory(context);
            },
            child: Container(
              width: 370,
              height: 108,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment(-1.00, -0.00),
                  end: Alignment(1, 0),
                  colors: [AppColors.secondary3, Colors.white], // Using AppColors for gradients
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment(-1.00, -0.00),
                        end: Alignment(1, 0),
                        colors: [AppColors.secondary3, Colors.white], // Using AppColors for gradients
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 28,
                          height: 28,
                          child: const Icon(Icons.search, color: AppColors.warningColor, size: 18), // Using AppColors for icon color
                        ),
                        Expanded(
                          child: Consumer<MealViewModel>(
                            builder: (context, momFood, child) {
                              return Autocomplete<String>(
                                optionsBuilder: (TextEditingValue textEditingValue) {
                                  if (textEditingValue.text.isEmpty) {
                                    return const Iterable<String>.empty();
                                  }
                                  return searchHistory.where((String option) {
                                    return option.contains(textEditingValue.text);
                                  });
                                },
                                onSelected: (String selection) {
                                  _controller.text = selection;
                                  widget.onSearch(selection);
                                  momFood.search(selection);
                                  _saveSearchQuery(selection);
                                  _controller.clear(); // Clear the text field after search
                                },
                                fieldViewBuilder: (BuildContext context, TextEditingController fieldTextEditingController, FocusNode fieldFocusNode, VoidCallback onFieldSubmitted) {
                                  _controller = fieldTextEditingController;
                                  return TextField(
                                    controller: fieldTextEditingController,
                                    focusNode: fieldFocusNode,
                                    decoration: const InputDecoration(
                                      hintText: 'البحث',
                                      border: InputBorder.none,
                                      isDense: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                                      hintStyle: TextStyle(
                                        color: AppColors.warningColor, // Using AppColors for hint color
                                        fontSize: 12,
                                        fontFamily: 'Encode Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 0.17,
                                      ),
                                    ),
                                    textAlign: TextAlign.right,
                                    onSubmitted: (query) {
                                      widget.onSearch(query);
                                      momFood.search(query);
                                      _saveSearchQuery(query);
                                      _controller.clear(); // Clear the text field after search
                                    },
                                  );
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
    );
  }

  void _showSearchHistory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: ListView.builder(
            itemCount: searchHistory.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(searchHistory[index]),
                onTap: () {
                  widget.onSearch(searchHistory[index]);
                  Provider.of<MealViewModel>(context, listen: false).search(searchHistory[index]);
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }
}