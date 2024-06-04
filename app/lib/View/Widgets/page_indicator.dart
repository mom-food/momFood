import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  final PageController controller;
  final Function(int)? onDotClicked;
  final int count;

  PageIndicator({
    required this.controller,
    required this.onDotClicked,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: SwapEffect(
        activeDotColor: Color(0xFF000000),
        dotColor: Color(0xFFD9D9D9),
        dotHeight: 15,
        dotWidth: 15,
      ),
      onDotClicked: onDotClicked,
    );
  }
}