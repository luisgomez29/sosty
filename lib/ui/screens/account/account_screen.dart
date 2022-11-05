import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/app_bottom_navigation_bar.dart';
import 'package:sosty/config/provider/user_provider.dart';
import 'package:sosty/domain/models/user/user.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/common/enums/shared_preferences_enum.dart';
import 'package:sosty/ui/components/account/account_info.dart';
import 'package:sosty/ui/components/account/profile_menu_item.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/load_data_error.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';
import 'package:sosty/ui/components/navbar/navbar.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';
import 'package:sosty/ui/helpers/launcher_helper.dart';
import 'package:sosty/ui/helpers/shared_preferences_helper.dart';
import 'package:sosty/ui/screens/auth/login_screen.dart';
import 'package:sosty/ui/screens/auth/signup_screen.dart';
import 'package:sosty/ui/screens/contact/contact_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with AutomaticKeepAliveClientMixin {
  String? _userId;
  Future<User>? _futureUser;

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userId = prefs.getString(SharedPreferencesEnum.userId.value);
    });
  }

  Future<void> _fetchUser() async {
    if (_userId != null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final user = userProvider.userUseCase.getUserByID(_userId!);
      setState(() {
        _futureUser = user;
      });
    }
  }

  void _logout(context) async {
    await SharedPreferencesHelper.deleteUserSessionData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const AppBottomNavigationBar(),
      ),
      (route) => false,
    );
  }

  void _goToScreen(Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Widget _getOptions() {
    return Column(
      children: [
        ProfileMenuItem(
          title: "Contáctanos",
          icon: Icons.people_alt_outlined,
          chevron: true,
          onTap: () => _goToScreen(const ContactScreen()),
        ),
        ProfileMenuItem(
          title: "Ayuda",
          icon: Icons.help_outline,
          onTap: () => LauncherHelper.launchInBrowser(
            Constants.sostyHelpUrl,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserData().then((_) {
      _fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      onRefresh: () async {
        _fetchUser();
      },
      child: CustomScrollView(
        slivers: <Widget>[
          const Navbar(),
          SliverToBoxAdapter(
            child: Column(
              children: <Widget>[
                const NavbarClipper(),
                ContentSection(
                  offsetY: -60.0,
                  paddingH: 0.0,
                  child: (_userId == null)
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 80.0,
                            ),
                            ProfileMenuItem(
                              title: "Iniciar sesión",
                              icon: Icons.login_outlined,
                              chevron: true,
                              onTap: () => _goToScreen(
                                const LoginScreen(),
                              ),
                            ),
                            ProfileMenuItem(
                              title: "Crear cuenta",
                              icon: Icons.account_circle_outlined,
                              chevron: true,
                              onTap: () => _goToScreen(
                                const SignupScreen(),
                              ),
                            ),
                            _getOptions(),
                          ],
                        )
                      : FutureBuilder<User>(
                          future: _futureUser,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    AccountInfo(
                                      user: snapshot.data!,
                                    ),
                                    ProfileMenuItem(
                                      title: "Contáctanos",
                                      icon: Icons.people_alt_outlined,
                                      chevron: true,
                                      onTap: () => _goToScreen(
                                        const ContactScreen(),
                                      ),
                                    ),
                                    ProfileMenuItem(
                                      title: "Ayuda",
                                      icon: Icons.help_outline,
                                      onTap: () =>
                                          LauncherHelper.launchInBrowser(
                                        Constants.sostyHelpUrl,
                                      ),
                                    ),
                                    ProfileMenuItem(
                                      title: "Cerrar sesión",
                                      icon: Icons.exit_to_app_outlined,
                                      onTap: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              '¿Quieres cerrar sesión?',
                                              textAlign: TextAlign.center,
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: const Text('No'),
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    _logout(context),
                                                child: const Text('Si'),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                            } else if (snapshot.hasError) {
                              if (kDebugMode) {
                                print(
                                    "GET_USER_BY_ID_ERROR => ${snapshot.error}");
                              }
                              return const LoadDataError();
                            }
                            return const LoadingIndicator();
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
