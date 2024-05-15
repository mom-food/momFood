import 'package:app/View/Screens/offer.dart';
import 'package:app/View/Screens/offer_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Model/search-model.dart';
import '../../themes/dark.dart';
import '../../themes/light.dart';
import '../Widgets/app_bar.dart';
import '../Widgets/home-tab.dart';
import '../Widgets/mom_food_title.dart';
import '../Widgets/nav_bar.dart';
import '../Widgets/search-bar.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    final momFood = Provider.of<MomFood>(context);

    return SafeArea(
      child: MaterialApp(
        themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light, // Set theme mode based on isDarkMode
        theme: lightMode, // Default theme
        darkTheme: darkMode, // Dark theme
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(130.0), // Adjust the height as needed
            child: Column(
              children: [
                MyAppBar(title: MomFoodTitle(), isLightTheme: !isDarkMode),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26.0),
                  child: CustomSearchBar(
                    onSearch: (query) {
                      momFood.search(query);
                    },
                  ), // Add the search bar inside the app bar
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: taps[_selectedIndex],
              ),
              if (momFood.categories.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: momFood.categories.length,
                  itemBuilder: (context, index) {
                    final category = momFood.categories[index];
                    return ListTile(
                      title: Text(category.name),
                      subtitle: Text('Price: ${category.price}, Offer: ${category.offer}'),
                      leading: Image.network(category.image),
                    );
                  },
                ),
              ),
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            selectedIndex: _selectedIndex,
            onItemTapped: (index) {
              setState(() {
                _selectedIndex = index; // Update the selected index
              });
            },
          ),
        ),
      ),
    );
  }

  List<Widget> taps = [
    OfferListView(),
    //const CartTap(),
    //const ProfileTap(),
  ];
}
