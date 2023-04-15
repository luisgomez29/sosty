import 'package:flutter/material.dart';
import 'package:sosty/ui/common/enums/assets_enum.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      snap: true,
      floating: true,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: Image(
        image: AssetImage(AssetsEnum.logo.value),
        height: 60,
      ),
      // leading: Image(
      //   image: AssetImage(AssetsEnum.logo.value),
      // ),
      // leadingWidth: 130,
      // actions: [
      //   IconButton(
      //     padding: const EdgeInsets.symmetric(horizontal: 16),
      //     icon: const Icon(
      //       Icons.search,
      //       color: Colors.white,
      //     ),
      //     tooltip: 'Buscar',
      //     onPressed: () {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(
      //           content: Text('This is a snackbar'),
      //         ),
      //       );
      //     },
      //   ),
      // ],
    );
  }
}
