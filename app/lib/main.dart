import 'dart:async';
import 'dart:io';
import 'package:app_links/app_links.dart';
import 'package:app/View/Screens/Authentication/EditProfile.dart';
import 'package:app/View/Screens/meal_details.dart';
import 'package:app/View/Screens/success_checkout_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'Services/user_services.dart';
import 'View/Screens/Authentication/SignIn.dart';
import 'View/Screens/Authentication/SignUp.dart';
import 'View/Screens/Authentication/ResetPassword.dart';
import 'View/Screens/Authentication/forgetPassword.dart';
import 'View/Screens/CategoryMeal.dart';
import 'View/Screens/MenuList.dart';
import 'View/Screens/HomePage.dart';
import 'View/Screens/OnBoarding1.dart';
import 'View/Screens/OnBoarding2.dart';
import 'View/Screens/SplashScreen.dart';
import 'View/Widgets/app_bar.dart';
import 'View/Screens/controller/sign_up_screen_controller.dart';
import 'ViewModel/meal_view_model.dart';
import 'themes/theme-provider.dart';
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
      builder: (context, state) => MealList(categoryId: state.pathParameters['categoryId']!),
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
      path: '/reset-password/:oobCode/:apiKey/:mode',
      builder: (context, state) => ResetPassword(state.pathParameters['oobCode']!),
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
  final _navigatorKey = GlobalKey<NavigatorState>();
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

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
      openAppLink(uri, context);
    });
  }

  void openAppLink(Uri uri, BuildContext context) {
    print("🔴 I'M TRYING TO OPEN ${uri.query}");

    if (uri.host == "resetpassword") {
      final oobCode = uri.queryParameters['oobCode'];
      final apiKey = uri.queryParameters['apiKey'];
      final mode = uri.queryParameters['mode'];

      if (oobCode == null) {
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
      _navigatorKey.currentState?.pushReplacementNamed(
          '/reset-password/$oobCode/$apiKey/$mode');
    }
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserServices()),
        ChangeNotifierProvider(create: (_) => MealViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => SignUpScreenController()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          print(_router.configuration);
          return MaterialApp.router(
           // navigatorKey: _navigatorKey,
            title: 'Flutter Demo',
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: themeProvider.isDarkMode ? darkMode : lightMode,
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}

class EpicScreen extends StatelessWidget {
  final RouteSettings settings;

  EpicScreen(this.settings);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Route name: ${settings.name?.split('/').join('\n')}"),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/onboarding1');
                },
                child: Text("Click")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/');
                },
                child: Text("Click"))
          ],
        )),
      ),
    ));
  }
}
