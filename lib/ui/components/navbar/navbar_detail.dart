import 'package:flutter/material.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/common/styles/styles.dart';

class NavbarDetail extends StatelessWidget {
  const NavbarDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SliverAppBar(
      pinned: false,
      snap: true,
      floating: true,
      centerTitle: true,
      backgroundColor: Styles.primaryColor,
      leading: BackButton(color: Colors.white),
      title: Image(
        image: AssetImage(assetLogo),
        height: 50,
      ),
    );
  }
}
