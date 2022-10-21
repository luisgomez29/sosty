import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/config/theme/app_theme.dart';
import 'package:sosty/ui/screens/login_screen.dart';
import 'package:sosty/ui/screens/on_boarding_screen.dart';
import 'package:sosty/domain/models/common/enums/shared_preferences_enum.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _seenOnboard = true;
  String? _accessToken;
  String? _userId;

  // Loading seenOnboard value on start
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _accessToken = prefs.getString(SharedPreferencesEnum.accessToken.value);
      _userId = prefs.getString(SharedPreferencesEnum.userId.value);
      _seenOnboard =
          prefs.getBool(SharedPreferencesEnum.seenOnboard.value) ?? false;
    });
  }

  Widget _getHome() {
    if (_seenOnboard == true) {
      if (_accessToken == null && _userId == null) {
        return const LoginScreen();
      }
      return const AppBottomNavigationBar();
    }
    return const OnBoardingScreen();
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        // set Status bar color in Android devices
        statusBarColor: Styles.primaryColor,

        // set Status bar icons color in Android devices
        statusBarIconBrightness: Brightness.light,

        // set Status bar icon color in iOS
        statusBarBrightness: Brightness.light,
      ),
    );

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
      ),
    );
  }
}
