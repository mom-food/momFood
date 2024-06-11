import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../colors.dart';
import '../Widgets/page_indicator.dart';
import 'on_boarding2.dart';

class Onboarding1 extends StatefulWidget {
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
      body: GestureDetector(
        onTap: () {
          context.go("/onboarding2");
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 90),
                child: Text(
                  "مرحباً",
                  style: TextStyle(
                      fontFamily: 'Manrope_SemiBold.ttf', fontSize: 32),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(width: 15),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: Container(
                  constraints:
                      BoxConstraints.expand(width: 219, height: 229.25),
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
                        fontFamily: 'Manrope_SemiBold.ttf',
                        fontSize: 26,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? AppColors.textColor2
                            : AppColors.textColor1,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'بكم',
                          style: TextStyle(
                            fontFamily: 'Manrope_SemiBold.ttf',
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.primary2
                                    : AppColors.primary1,
                          ),
                        ),
                        TextSpan(
                            text: ' في ',
                            style: TextStyle(
                              fontFamily: 'Manrope_SemiBold.ttf',
                            )),
                        TextSpan(
                          text: 'عالم',
                          style: TextStyle(
                            fontFamily: 'Manrope_SemiBold.ttf',
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.primary2
                                    : AppColors.primary1,
                          ),
                        ),
                        TextSpan(
                            text: ' النكهات ',
                            style: TextStyle(
                              fontFamily: 'Manrope_SemiBold.ttf',
                            )),
                        TextSpan(
                          text: 'الاصيلة',
                          style: TextStyle(
                            fontFamily: 'Manrope_SemiBold.ttf',
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.primary2
                                    : AppColors.primary1,
                          ),
                        ),
                        TextSpan(
                            text: ', حيث كل ',
                            style: TextStyle(
                              fontFamily: 'Manrope_SemiBold.ttf',
                            )),
                        TextSpan(
                          text: 'طبق',
                          style: TextStyle(
                            fontFamily: 'Manrope_SemiBold.ttf',
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.primary2
                                    : AppColors.primary1,
                          ),
                        ),
                        TextSpan(
                            text: ' يروي ',
                            style: TextStyle(
                              fontFamily: 'Manrope_SemiBold.ttf',
                            )),
                        TextSpan(
                          text: 'قصته',
                          style: TextStyle(
                            fontFamily: 'Manrope_SemiBold.ttf',
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.primary2
                                    : AppColors.primary1,
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
                          MaterialPageRoute(
                              builder: (context) => Onboarding2Screen()),
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
