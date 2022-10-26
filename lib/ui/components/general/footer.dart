import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/buttons/small_button_navigation.dart';
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
        SmallButtonNavigation(
          buttonText: "Contáctenos",
          textStyle: Styles.bodyText2.copyWith(
            color: Theme.of(context).primaryColor,
          ),
          page: const ContactScreen(),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
