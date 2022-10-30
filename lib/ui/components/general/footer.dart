import 'package:flutter/material.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/buttons/small_button_navigation.dart';
import 'package:sosty/ui/helpers/launcher_helper.dart';
import 'package:sosty/ui/screens/contact/contact_screen.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 40,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SmallButtonNavigation(
              buttonText: "Ayuda",
              textStyle: Styles.bodyText2.copyWith(
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () => LauncherHelper.launchInBrowser(
                Constants.sostyHelpUrl,
              ),
            ),
            SmallButtonNavigation(
              buttonText: "Contáctenos",
              textStyle: Styles.bodyText2.copyWith(
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactScreen(),
                  ),
                );
              },
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
