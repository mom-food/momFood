import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Widgets/Button/sign_in_button.dart';
import '../Widgets/Button/sign_up_button.dart';
import '../Widgets/Button/continue_as_guest_button.dart';
import '../Widgets/page_indicator.dart';
import 'on_boarding1.dart';

class Onboarding2Screen extends StatelessWidget {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'assets/images/onboarding2.png',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SignUpButton(onPressed: () {
                            // Handle Sign Up Logic
                            context.go("/sign-up");
                          }),
                        ),
                        SizedBox(width: 15), // Spacing between the buttons
                        Expanded(
                          child: SignInButton(onPressed: () {
                            context.go("/signIn");
                          }),
                        ),
                      ],
                    ),
                    ContinueAsGuestButton(onPressed: () {
                      context.go("/");
                    }),
                    SizedBox(height: 10), // Spacing after "Continue as Guest" button
                    Center(
                      child: PageIndicator(
                        controller: _pageController, // Use the same PageController
                        count: 2,
                        onDotClicked: (index) {
                          if (index == 1) {
                            Navigator.pop(
                              context,
                              MaterialPageRoute(builder: (context) => Onboarding1()),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 45), // Spacing from the bottom
            ],
          ),
        ],
      ),
    );
  }
}