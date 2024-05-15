import 'package:flutter/material.dart';
import '../Widgets/Button/SignInButton.dart';
import '../Widgets/Button/SignUpButton.dart';
import '../Widgets/Button/continue_as_guest_button.dart';
import '../Widgets/PageIndicator.dart';
import 'OnBoarding1.dart';

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
                          Navigator.pushNamed(context, '/signUp');
                        }),
                      ),
                      SizedBox(width: 15), // Spacing between the buttons
                      Expanded(
                        child: SignInButton(
                            onPressed: () {
                              // Handle Sign In Logic
                              Navigator.pushNamed(context, '/signIn');
                            }
                        ),
                      ),
                    ],
                  ),
                  ContinueAsGuestButton(
                      onPressed: (){
                        Navigator.pushReplacementNamed(context, '/offer');
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
