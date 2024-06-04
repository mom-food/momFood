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
          Positioned(
            bottom: 45,
            left: 20,
            right: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SignUpButton(onPressed: (){
                          // Handle Sign Up Logic
                          context.go("/sign-up");
                        }),
                      ),
                      SizedBox(width: 15), // Spacing between the buttons
                      Expanded(
                        child: SignInButton(
                            onPressed: () {
                              context.go("/signIn");
                            }
                        ),
                      ),
                    ],
                  ),
                  ContinueAsGuestButton(
                      onPressed: (){
                        context.go("/");
                      }
                  ),
                  SizedBox(height: 10), // Spacing after "Complete as a guest" button
                  Center(
                    child: PageIndicator(
                      controller: _pageController, // Use the same PageController
                      count: 2,
                      onDotClicked: (index) {
                        if(index==1){
                          Navigator.pop(
                            context,
                            MaterialPageRoute(builder: (context) => Onboarding1()),
                          );}
                      },
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
}
