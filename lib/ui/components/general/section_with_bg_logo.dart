import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class SectionWithBgLogo extends StatelessWidget {
  const SectionWithBgLogo({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Image(
          image: AssetImage("assets/images/logo_with_decoration.jpg"),
          fit: BoxFit.cover,
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title,
                style: Styles.headline1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
