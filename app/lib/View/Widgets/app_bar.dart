import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themes/theme-provider.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
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
<<<<<<< HEAD
    return AppBar(
      title: Column(
        children: [
          SizedBox(
            width: 294,
            height: 43,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'M',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: 'o',
                    style: TextStyle(
                      color: isLightTheme ? Color(0xFFFF9500) : Colors.white, // تم تعديل هنا لتناسب الثيم
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: 'm ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: 'F',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: 'Oo',
                    style: TextStyle(
                      color: isLightTheme ? Color(0xFFFF9500) : Colors.white, // تم تعديل هنا لتناسب الثيم
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  TextSpan(
                    text: 'd',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontFamily: 'Encode Sans',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: isLightTheme ? Colors.white : Colors.black, // تم تعديل هنا لتناسب الثيم
      automaticallyImplyLeading: false,
=======
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
>>>>>>> origin/home
    );
  }
}
