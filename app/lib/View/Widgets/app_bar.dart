import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themes/theme-provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic title;
  final bool isLightTheme;

  const MyAppBar({
    Key? key,
    required this.title,
    required this.isLightTheme,

  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AppBar(
          title: _buildTitleWidget(),
          centerTitle: true,
          backgroundColor:
          themeProvider.isDarkMode ? Colors.black : Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(
                themeProvider.getThemeIcon(),
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              onPressed: () {
                themeProvider.toggleTheme();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTitleWidget() {
    if (title is String) {
      return Text(
        title,
      );
    } else if (title is Widget) {
      return title;
    } else {
      return Container();
    }
  }
}
