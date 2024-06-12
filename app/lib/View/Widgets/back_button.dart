import 'package:flutter/material.dart' show BuildContext, Color, Icon, IconButton, Icons, Navigator, PageController, StatelessWidget, VoidCallback, Widget;


class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  CustomBackButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: onPressed ?? () {
        Navigator.of(context).pop();
      },
    );
  }
}
