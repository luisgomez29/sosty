import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/config/theme/light_theme.dart';
import 'package:sosty/ui/screens/login_screen.dart';
import 'package:sosty/ui/screens/on_boarding_screen.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sosty',
      theme: lightTheme,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home:
          _seenOnboard == true ? const LoginScreen() : const OnBoardingScreen(),
    );
  }
}
