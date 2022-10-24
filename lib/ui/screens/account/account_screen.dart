import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/config/provider/user_provider.dart';
import 'package:sosty/ui/common/enums/shared_preferences_enum.dart';
import 'package:sosty/domain/models/user/user.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/account/account_info.dart';
import 'package:sosty/ui/components/account/profile_menu_item.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/general/load_data_error.dart';
import 'package:sosty/ui/components/general/loading_indicator.dart';
import 'package:sosty/ui/components/navbar/navbar.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';
import 'package:sosty/ui/helpers/shared_preferences_helper.dart';
import 'package:sosty/ui/screens/login_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String? userId;
  Future<User>? futureUser;

  Future<void> _loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString(SharedPreferencesEnum.userId.value) ??
          SharedPreferencesEnum.keyNotFound.value;
    });
  }

  Future<User> fetchUser() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    return userProvider.userUseCase.getUserByID(userId!);
  }

  void _logout(context) async {
    await SharedPreferencesHelper.deleteUserSessionData();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false);
  }

  @override
  void initState() {
    super.initState();
    _loadUserId().then((_) {
      futureUser = fetchUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const Navbar(),
        SliverToBoxAdapter(
          child: Column(
            children: <Widget>[
              const NavbarClipper(),
              ContentSection(
                offsetY: -70.0,
                paddingH: 0.0,
                child: FutureBuilder<User>(
                  future: futureUser,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        final User user = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            AccountInfo(
                              imageUrl: user.profilePictureUrl,
                              name:
                                  "${user.profileDetails[0].firstName} ${user.profileDetails[0].lastName}",
                              email: user.email,
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            ContentSection(
                              offsetY: 0.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    "Celular",
                                    style: Styles.bodyText1Bold,
                                  ),
                                  Text(
                                    user.profileDetails[0].contactCellphone,
                                    style: Styles.bodyText1,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Ubicación",
                                    style: Styles.bodyText1Bold,
                                  ),
                                  Text(
                                    "${user.profileDetails[0].city ?? ""} - ${user.profileDetails[0].state ?? ""}",
                                    style: Styles.bodyText1,
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  const Divider(),
                                ],
                              ),
                            ),
                            ProfileMenuItem(
                              title: "Cerrar sesión",
                              icon: Icons.exit_to_app_outlined,
                              onTap: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
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
                                ),
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
