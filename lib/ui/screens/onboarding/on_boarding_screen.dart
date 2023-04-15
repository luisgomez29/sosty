import 'package:flutter/material.dart';
import 'package:sosty/app_bottom_navigation_bar.dart';
import 'package:sosty/ui/common/enums/assets_enum.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/buttons/large_button.dart';
import 'package:sosty/ui/components/clippers/wave_clipper.dart';
import 'package:sosty/ui/helpers/on_boarding_helper.dart';
import 'package:sosty/ui/helpers/shared_preferences_helper.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    SharedPreferencesHelper.saveSeenOnboard();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentPage = value;
                  });
                },
                itemCount: onBoardingContents.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: WaveClipper(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    onBoardingContents[index].image,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: FractionalOffset.topCenter,
                                  end: FractionalOffset.bottomCenter,
                                  colors: [
                                    Colors.grey.withOpacity(0.0),
                                    Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                  ],
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage(AssetsEnum.logo.value),
                                    height: 100,
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 15,
                          right: Styles.paddingContent,
                          bottom: 15,
                          left: Styles.paddingContent,
                        ),
                        child: Column(
                          children: [
                            Text(
                              onBoardingContents[index].title,
                              style: Styles.headline1,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              onBoardingContents[index].description,
                              style: Styles.bodyText1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // _getWidgetButtonNavigationBar(),
                  ButtonNavigationBar(
                    currentPage: _currentPage,
                    pageController: _pageController,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    required this.currentPage,
    required this.index,
  }) : super(key: key);

  final int currentPage;
  final int index;

  @override
  Widget build(BuildContext context) {
    final isActive = currentPage == index;
    return AnimatedContainer(
      height: isActive ? 20 : 10,
      width: 10,
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color:
            isActive ? Theme.of(context).primaryColor : Styles.secondaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(22),
        ),
      ),
    );
  }
}

class ButtonNavigationBar extends StatelessWidget {
  const ButtonNavigationBar({
    Key? key,
    required this.currentPage,
    required this.pageController,
  }) : super(key: key);

  final int currentPage;
  final PageController pageController;

  void _goToProjectsScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AppBottomNavigationBar(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return currentPage == onBoardingContents.length - 1
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: LargeButton(
              text: "Iniciar",
              onPressed: () => _goToProjectsScreen(context),
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: () => _goToProjectsScreen(context),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
                child: Text(
                  "Omitir",
                  textAlign: TextAlign.center,
                  style: Styles.bodyText1Bold,
                ),
              ),
              Row(
                children: List.generate(
                  onBoardingContents.length,
                  (index) => DotIndicator(
                    index: index,
                    currentPage: currentPage,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_sharp),
                iconSize: 32.0,
                selectedIcon: const Icon(Icons.settings),
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          );
  }
}
