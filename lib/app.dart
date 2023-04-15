import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/app_bottom_navigation_bar.dart';
import 'package:sosty/config/provider/investment_provider.dart';
import 'package:sosty/config/provider/project_provider.dart';
import 'package:sosty/config/provider/user_provider.dart';
import 'package:sosty/domain/use_cases/investment/investment_use_case.dart';
import 'package:sosty/domain/use_cases/project/project_use_case.dart';
import 'package:sosty/domain/use_cases/user/user_use_case.dart';
import 'package:sosty/infraestructure/driven_adapter/investment_api/investment_api.dart';
import 'package:sosty/infraestructure/driven_adapter/project_api/project_api.dart';
import 'package:sosty/infraestructure/driven_adapter/user_api/user_api.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(
            userUseCase: UserUseCase(UserApi()),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => InvestmentProvider(
            investmentUseCase: InvestmentUseCase(InvestmentApi()),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => ProjectProvider(
            projectUseCase: ProjectUseCase(ProjectApi()),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sosty',
        theme: AppTheme.light(context),
        home: _getHome(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
