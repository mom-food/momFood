import 'dart:async';
import 'dart:io';
import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'View/Screens/Authentication/SignIn.dart';
import 'View/Screens/Authentication/SignUp.dart';
import 'View/Screens/Authentication/ResetPassword.dart';
import 'View/Screens/Authentication/forget_password.dart';
import 'View/Screens/controller/sign_up_screen_controller.dart';
import 'View/Widgets/app_bar.dart';
import 'ViewModel/meal_view_model.dart';
import 'View/Screens/Home.dart';
import 'View/Screens/OnBoarding1.dart';
import 'View/Screens/OnBoarding2.dart';
import 'View/Screens/SplashScreen.dart';
import 'themes/theme-provider.dart';
import 'themes/dark.dart';
import 'themes/light.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "YOUR_API_KEY",
          appId: "YOUR_APP_ID",
          messagingSenderId: "YOUR_MESSAGING_SENDER_ID",
          projectId: "YOUR_PROJECT_ID",
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
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

    // Handle links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      print('onAppLink: $uri');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) {
    print("🔴 I'M TRYING TO OPEN ${uri.query}");

    if (uri.host == "resetpassword") {
      print("queryParams: ${uri.queryParameters}");
      final oobCode = uri.queryParameters['oobCode'];
      final apiKey = uri.queryParameters['apiKey'];
      final mode = uri.queryParameters['mode'];

      // نتأكد أنهم موجودات فعلًا
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
      Navigator.pushReplacementNamed(
          context, '/reset-password/$oobCode/$apiKey/$mode');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MealViewModel()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
          ChangeNotifierProvider(create: (_) => SignUpScreenController()),
        ],
        child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
      return MaterialApp(
          title: 'Flutter Demo',
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          theme: themeProvider.isDarkMode ? darkMode : lightMode,
          debugShowCheckedModeBanner: false,
          home: Scaffold(
          appBar: MyAppBar(
          title: 'Mom Food',
          isLightTheme: !themeProvider.isDarkMode,
      ),
    body: SplashScreen(),
    floatingActionButton: FloatingActionButton(
    onPressed: () {
    themeProvider.toggleTheme();
    },
    tooltip: 'Switch',
    child: Icon(
    themeProvider.getThemeIcon(),
    ),
    ),
    ),
    onGenerateRoute: (settings) {
    Widget routeWidget = Onboarding1();

    final routeName = settings.name;
    if (routeName != null) {
    if (routeName.startsWith('/onboarding1')) {
    routeWidget = Onboarding1();
    } else if (routeName.startsWith('/onboarding2')) {
    routeWidget = Onboarding2Screen();
    } else if (routeName == '/offer') {
    routeWidget = HomePage();
    } else if (routeName == '/sign-up') {
    routeWidget = SignUpScreen();
    } else if (routeName == '/signIn') {
    routeWidget = SignInScreen();
    } else if (routeName == '/forget-password') {
    routeWidget = ForgetPassword();
    } else if (routeName.startsWith('/reset-password')) {
    try {
    final parameters = settings.name
        ?.split('/reset-password')
        .where((element) => element.isNotEmpty)
    .toList() ??

        [];
    parameters.removeAt(0); // /reset-password/oobCode/apiKey/idk
    final oobCode = parameters[0];
    print("SETTINGS ${parameters}");
    routeWidget = ResetPassword(oobCode);
    } catch (e) {
      print("Error parsing route name");
    }
    }
    }

    return MaterialPageRoute(
      builder: (context) => routeWidget,
      settings: settings,
      fullscreenDialog: true,
    );
    },
      );
        },
        ),
    );
  }
}
