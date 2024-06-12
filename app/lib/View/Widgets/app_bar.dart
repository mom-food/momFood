import 'package:flutter/material.dart';

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
      backgroundColor: isLightTheme ? Colors.white : Colors.black,
      automaticallyImplyLeading: false,
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
