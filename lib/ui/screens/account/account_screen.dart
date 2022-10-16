import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/account/account_info.dart';
import 'package:sosty/ui/components/general/content_section.dart';
import 'package:sosty/ui/components/navbar/navbar.dart';
import 'package:sosty/ui/components/navbar/navbar_clipper.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        const Navbar(),
        SliverToBoxAdapter(
          child: Column(
            children: [
              const NavbarClipper(),
              ContentSection(
                offsetY: -70.0,
                paddingH: 0.0,
                child: Column(
                  children: [
                    const AccountInfo(
                      imageUrl:
                          "https://sosty.blob.core.windows.net/sosty-public-files/20220520215423.jpeg",
                      name: "Jose Miguel Moreno López",
                      email: "jose@gmail.com",
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15.0,
                        ),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Material(
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.1),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.exit_to_app_outlined,
                                    size: 24,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Cerrar sesión",
                              style: Styles.bodyText1.copyWith(
                                fontSize: 17.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
