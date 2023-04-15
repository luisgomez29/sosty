import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/app/app_bottom_navigation_bar.dart';
import 'package:sosty/main.dart';
import 'package:sosty/ui/common/enums/shared_preferences_enum.dart';
import 'package:sosty/ui/config/theme/app_theme.dart';
import 'package:sosty/ui/screens/onboarding/on_boarding_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _seenOnboard = true;

  // Loading seenOnboard value on start
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _seenOnboard =
          prefs.getBool(SharedPreferencesEnum.seenOnboard.value) ?? false;
    });
  }

  Widget _getHome() {
    return _seenOnboard == true
        ? const AppBottomNavigationBar()
        : const OnBoardingScreen();
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   AppTheme.getSystemUiOverlayStyle(),
    // );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sosty',
      theme: AppTheme.light(context),
      home: _getHome(),
      navigatorKey: navigatorKey,
    );
  }
}
