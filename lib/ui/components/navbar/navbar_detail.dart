import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/common/enums/assets_enum.dart';

class NavbarDetail extends StatelessWidget {
  const NavbarDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      snap: true,
      floating: true,
      centerTitle: true,
      backgroundColor: Styles.primaryColor,
      leading: const BackButton(color: Colors.white),
      title: Image(
        image: AssetImage(AssetsEnum.logo.value),
        height: 50,
      ),
    );
  }
}
