import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../colors.dart';
import '../Widgets/PageIndicator.dart';
import 'Home.dart';
import 'OnBoarding2.dart';

class Onboarding1 extends StatefulWidget {
 // final ThemeMode themeMode;

  Onboarding1();

  @override
  _Onboarding1State createState() => _Onboarding1State();
}

class _Onboarding1State extends State<Onboarding1> {
  PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: widget.themeMode == ThemeMode.light ? Colors.white : Colors.black12,

      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Onboarding2Screen()),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Text(
                  "مرحباً",
                  style: TextStyle(fontSize: 32),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(width: 15),

              Padding(
                padding: const EdgeInsets.only(top: 50,left: 20),
                child: Container(
                  constraints: BoxConstraints.expand(width: 219, height: 229.25),
                  child: Image.asset(
                    'assets/images/Onboarding1.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: RichText(
                    text: TextSpan(
                      text: ' اهلا ',
                      style: TextStyle(
                        fontSize: 26,
                        color: Theme.of(context).brightness == Brightness.dark ? AppColors.textColor2 : AppColors.textColor1,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'بكم',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness == Brightness.dark ? AppColors.primary2 : AppColors.primary1,
                          ),
                        ),
                        TextSpan(
                          text: ' في ',

                        ),
                        TextSpan(
                          text: 'عالم',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness == Brightness.dark ? AppColors.primary2 : AppColors.primary1,
                          ),
                        ),
                        TextSpan(text: ' النكهات ',),
                        TextSpan(
                          text: 'الاصيلة',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness == Brightness.dark ? AppColors.primary2 : AppColors.primary1,
                          ),
                        ),
                        TextSpan(text: ', حيث كل '),
                        TextSpan(
                          text: 'طبق',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness == Brightness.dark ? AppColors.primary2 : AppColors.primary1,
                          ),
                        ),
                        TextSpan(text: ' يروي '),
                        TextSpan(
                          text: 'قصته',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness == Brightness.dark ? AppColors.primary2 : AppColors.primary1,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: PageIndicator(
                    controller: _pageController,
                    count: 2,
                    onDotClicked: (index) {
                      if (index == 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Onboarding2Screen()),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}