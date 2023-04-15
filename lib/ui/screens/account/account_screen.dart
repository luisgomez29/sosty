import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/app/app_bottom_navigation_bar.dart';
import 'package:sosty/config/providers/user_provider.dart';
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

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen>
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
      final user = ref.read(userProvider).getUserByID(_userId!);
      setState(() {
        _futureUser = user;
      });
    }
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
                      ? const AccountScreenWithoutSession()
                      : AccountScreenWithSession(
                          futureUser: _futureUser!,
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

class HelpOptions extends StatelessWidget {
  const HelpOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuItem(
          title: "Contáctanos",
          icon: Icons.people_alt_outlined,
          chevron: true,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ContactScreen(),
            ),
          ),
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
}

class AccountScreenWithSession extends StatefulWidget {
  const AccountScreenWithSession({
    Key? key,
    required this.futureUser,
  }) : super(key: key);

  final Future<User> futureUser;

  @override
  State<AccountScreenWithSession> createState() =>
      _AccountScreenWithSessionState();
}

class _AccountScreenWithSessionState extends State<AccountScreenWithSession> {
  void _logout(BuildContext context) async {
    await SharedPreferencesHelper.deleteUserSessionData();
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const AppBottomNavigationBar(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: widget.futureUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                AccountInfo(
                  user: snapshot.data!,
                ),
                const HelpOptions(),
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
                            onPressed: () => Navigator.pop(context),
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () => _logout(context),
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
            print("GET_USER_BY_ID_ERROR => ${snapshot.error}");
          }
          return const LoadDataError();
        }
        return const LoadingIndicator();
      },
    );
  }
}

class AccountScreenWithoutSession extends StatelessWidget {
  const AccountScreenWithoutSession({Key? key}) : super(key: key);

  void _goToScreen(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 80.0,
        ),
        ProfileMenuItem(
          title: "Iniciar sesión",
          icon: Icons.login_outlined,
          chevron: true,
          onTap: () => _goToScreen(
            context,
            const LoginScreen(),
          ),
        ),
        ProfileMenuItem(
          title: "Crear cuenta",
          icon: Icons.account_circle_outlined,
          chevron: true,
          onTap: () => _goToScreen(
            context,
            const SignupScreen(),
          ),
        ),
        const HelpOptions(),
      ],
    );
  }
}
