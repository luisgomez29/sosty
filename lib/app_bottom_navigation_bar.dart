import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/config/theme/app_theme.dart';
import 'package:sosty/ui/screens/account/account_screen.dart';
import 'package:sosty/ui/screens/investments/investments_screen.dart';
import 'package:sosty/ui/screens/projects/projects_screen.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    Key? key,
    this.indexPage,
  }) : super(key: key);
  final int? indexPage;

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int currentPageIndex = 0;
  final PageController _pageController = PageController();

  void _onDestinationSelectedState(int index) {
    setState(() {
      currentPageIndex = widget.indexPage ?? index;
    });
    _pageController.jumpToPage(index);
  }

  // Main screens
  final List<Widget> widgetsChildren = const [
    ProjectsScreen(),
    InvestmentsScreen(),
    AccountScreen(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: AppTheme.getSystemUiOverlayStyle(),
      child: Scaffold(
        body: SafeArea(
          child: PageView.builder(
            itemCount: widgetsChildren.length,
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return widgetsChildren[index];
            },
          ),
        ),
        bottomNavigationBar: NavigationBar(
          surfaceTintColor: Colors.white,
          backgroundColor: Styles.screenBackgroundColor,
          onDestinationSelected: _onDestinationSelectedState,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.assignment_outlined),
              selectedIcon: Icon(
                Icons.assignment,
                color: Colors.white,
              ),
              label: 'Proyectos',
            ),
            NavigationDestination(
              icon: Icon(Icons.assessment_outlined),
              selectedIcon: Icon(
                Icons.assessment_sharp,
                color: Colors.white,
              ),
              label: 'Inversiones',
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle_outlined),
              selectedIcon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
              label: 'Cuenta',
            ),
          ],
        ),
      ),
    );
  }
}
