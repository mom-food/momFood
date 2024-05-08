import 'package:flutter/material.dart' show BuildContext, Color, Icon, IconButton, Icons, Navigator, PageController, StatelessWidget, VoidCallback, Widget;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


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
