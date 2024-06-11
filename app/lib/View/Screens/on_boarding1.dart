import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../colors.dart';
import '../Widgets/page_indicator.dart';
import 'on_boarding2.dart';

class Onboarding1 extends StatefulWidget {
  const Onboarding1({super.key});

  @override
  Onboarding1State createState() => Onboarding1State();
}

class Onboarding1State extends State<Onboarding1> {
  final PageController _pageController = PageController();

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
              const Padding(
                padding: EdgeInsets.only(top: 90),
                child: Text(
                  "مرحباً",
                  style: TextStyle(
                      fontFamily: 'Manrope_SemiBold.ttf', fontSize: 32),
                ),
              ),
              const SizedBox(height: 15,width: 15),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20),
                child: Container(
                  constraints:
                      const BoxConstraints.expand(width: 219, height: 229.25),
                  child: Image.asset(
                    'assets/images/Onboarding1.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 15,width: 15),
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
                        const TextSpan(
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
                        const TextSpan(
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
                        const TextSpan(
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
                        const TextSpan(
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
              const SizedBox(height: 15),
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
