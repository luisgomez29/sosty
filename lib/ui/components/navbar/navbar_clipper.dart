import 'package:flutter/material.dart';
import 'package:sosty/ui/components/clippers/border_radius_clipper.dart';

class NavbarClipper extends StatelessWidget {
  const NavbarClipper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0.0, -1.0),
      child: BorderRadiusClipper(
        child: Container(
          height: 115,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
