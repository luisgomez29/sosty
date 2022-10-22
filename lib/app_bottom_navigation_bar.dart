import 'package:flutter/material.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/screens/account/account_screen.dart';
import 'package:sosty/ui/screens/investments/investments_screen.dart';
import 'package:sosty/ui/screens/projets/projects_screen.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    Key? key,
    this.indexPage,
  }) : super(key: key);
  final int? indexPage;

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int currentPageIndex = 0;

  void _onDestinationSelectedState(int index) {
    setState(() {
      currentPageIndex = widget.indexPage ?? index;
    });
  }

  // Main screens
  final List<Widget> widgetsChildren = const [
    InvestmentsScreen(),
    ProjectsScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: widgetsChildren[currentPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Styles.screenBackgroundColor,
        onDestinationSelected: _onDestinationSelectedState,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.assessment_outlined),
            selectedIcon: Icon(
              Icons.assessment_sharp,
              color: Colors.white,
            ),
            label: 'Inversiones',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_outlined),
            selectedIcon: Icon(
              Icons.assignment,
              color: Colors.white,
            ),
            label: 'Proyectos',
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
    );
  }
}
