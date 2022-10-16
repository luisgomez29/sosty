import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/config/theme/app_theme.dart';
import 'package:sosty/ui/screens/login_screen.dart';
import 'package:sosty/ui/screens/on_boarding_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _seenOnboard = false;

  // Loading seenOnboard value on start
  Future<void> _loadSeenOnboard() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _seenOnboard = prefs.getBool(seenOnboardPref) ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSeenOnboard();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        // set Status bar color in Android devices
        statusBarColor: Styles.primaryColor,

        // set Status bar icons color in Android devices
        statusBarIconBrightness: Brightness.dark,

        // set Status bar icon color in iOS
        statusBarBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sosty',
      theme: AppTheme.light(context),
      home:
          _seenOnboard == true ? const LoginScreen() : const OnBoardingScreen(),
    );
  }
}
