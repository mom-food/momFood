import 'package:flutter/material.dart';
import '../../colors.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final dynamic title;
  final bool isLightTheme;

  const MyAppBar({
    super.key,
    required this.title,
    required this.isLightTheme,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _buildTitleWidget(),
      centerTitle: true,
      backgroundColor: isLightTheme ? AppColors.backgroundColorLight : AppColors.backgroundColorDark,
      automaticallyImplyLeading: false,
    );
  }

  Widget _buildTitleWidget() {
    if (title is String) {
      return Text(
        title,
        style: TextStyle(
          color: isLightTheme ? AppColors.textColor1 : AppColors.textColor2,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'Encode Sans', // Adjust the font family as needed
        ),
      );
    } else if (title is Widget) {
      return title;
    } else {
      return Container();
    }
  }
}
