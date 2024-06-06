import 'dart:async';
import 'dart:io';
import 'package:app/themes/theme_provider.dart';
import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'Services/user_services.dart';
import 'View/Screens/Authentication/EditProfile.dart';
import 'View/Screens/Authentication/congratulatory_message.dart';
import 'View/Screens/Authentication/cubit/phone_auth/phone_auth_cubit.dart';
import 'View/Screens/Authentication/forget_password.dart';
import 'View/Screens/Authentication/otp/otp_screen.dart';
import 'View/Screens/Authentication/reset_password.dart';
import 'View/Screens/Authentication/sign_in.dart';
import 'View/Screens/Authentication/sign_up.dart';
import 'View/Screens/category_meal.dart';
import 'View/Screens/home_page.dart';
import 'View/Screens/meal_details.dart';
import 'View/Screens/menu_list.dart';
import 'View/Screens/on_boarding1.dart';
import 'View/Screens/on_boarding2.dart';
import 'View/Screens/success_checkout_screen.dart';
import 'ViewModel/meal_view_model.dart';
import 'ViewModel/sign_up_view_model.dart';
import 'themes/dark.dart';
import 'themes/light.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyAh1_uBnxz3toNPno1uvm0knZwtOwSKrek",
          appId: "1:175323531680:android:5cb7cd5c3878a57d47fcc5",
          messagingSenderId: "175323531680",
          projectId: "momfood-6ae63",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    print("Firebase initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(MyApp());
}

final _router = GoRouter(
  initialLocation: "/onboarding1",
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomePageScreen(),
    ),
    GoRoute(
      path: '/signIn',
      builder: (context, state) => SignInScreen(),
    ),
    GoRoute(
      path: '/sign-up',
      builder: (context, state) => SignUpScreen(),
    ),
    GoRoute(
      path: '/onboarding1',
      builder: (context, state) => Onboarding1(),
    ),
    GoRoute(
      path: '/onboarding2',
      builder: (context, state) => Onboarding2Screen(),
    ),
    GoRoute(
      path: '/MealCategoryScreen',
      builder: (context, state) => MealCategoryScreen(),
    ),
    GoRoute(
      path: '/mealDetailsScreen/:mealId',
      builder: (context, state) =>
          MealDetailsScreen(mealId: state.pathParameters['mealId']!),
    ),
    GoRoute(
      path: '/meal-list/:categoryId',
      builder: (context, state) =>
          MealList(categoryId: state.pathParameters['categoryId']!),
    ),
    GoRoute(
      path: '/successful_checkout',
      builder: (context, state) => SuccessMessageScreen(),
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => EditProfileScreen(),
    ),
    GoRoute(
      path: '/otp',
      builder: (context, state) => OtpScreen(
        phoneNumber: '0569359015', // Update this accordingly
      ),
    ),
    GoRoute(
      path: '/SuccessDialog',
      builder: (context, state) => SuccessDialog(),
    ),
    GoRoute(
      path: '/forget-password',
      builder: (context, state) => ForgetPassword(),
    ),
    GoRoute(
      path: '/reset-password/:oobCode',
      builder: (context, state) =>
          ResetPassword(state.pathParameters['oobCode']!),
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();
    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      print('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    print("🔴 I'M TRYING TO OPEN ${uri.query}");

    if (uri.host == "resetpassword") {
      final oobCode = uri.queryParameters['oobCode'];
      final apiKey = uri.queryParameters['apiKey'];
      final mode = uri.queryParameters['mode'];
      if (oobCode != null) {
        _router.go('/reset-password/$oobCode');
        print("Could not find oobCode");
        return;
      } else if (apiKey == null) {
        print("Could not find apiKey");
        return;
      } else if (mode == null) {
        print("Could not find mode");
        return;
      }
      print("SUCCESSFULLY FOUND THE HOST");
      Navigator.pushReplacementNamed(context, '/reset-password/$oobCode');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => PhoneAuthCubit())],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserServices()),
          ChangeNotifierProvider(create: (_) => MealViewModel()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => SignUpScreenController()),
        ],
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            return MaterialApp.router(
              title: 'Flutter Demo',
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              theme: themeProvider.isDarkMode ? darkMode : lightMode,
              debugShowCheckedModeBanner: false,
              routerConfig: _router,
            );
          },
        ),
      ),
    );
  }
}
