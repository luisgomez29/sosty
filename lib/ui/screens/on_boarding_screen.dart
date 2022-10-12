import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sosty/ui/common/constants/constants.dart';
import 'package:sosty/ui/common/styles/styles.dart';
import 'package:sosty/ui/components/buttons/large_button.dart';
import 'package:sosty/ui/components/clippers/wave_clipper.dart';
import 'package:sosty/ui/helpers/on_boarding.dart';
import 'package:sosty/ui/screens/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;
  final Duration animatedDuration = const Duration(milliseconds: 300);
  final PageController _pageController = PageController(initialPage: 0);

  /// Set value to not show on boarding screens again
  Future<void> _setSeenOnboard() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(seenOnboardPref, true);
  }

  AnimatedContainer _dotIndicator(index) {
    final isActive = _currentPage == index;

    return AnimatedContainer(
      height: isActive ? 20 : 10,
      width: 10,
      margin: const EdgeInsets.only(right: 5),
      duration: animatedDuration,
      decoration: BoxDecoration(
        color:
            isActive ? Theme.of(context).primaryColor : Styles.secondaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(22),
        ),
      ),
    );
  }

  void _goToLoginScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  Widget _getWidgetButtonNavigationBar() {
    return _currentPage == onBoardingContents.length - 1
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: LargeButton(
              text: "Iniciar",
              onPressed: _goToLoginScreen,
            ),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(
                onPressed: _goToLoginScreen,
                child: Text(
                  "Omitir",
                  textAlign: TextAlign.center,
                  style: Styles.bodyText1Bold,
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                ),
              ),
              Row(
                children: List.generate(
                    onBoardingContents.length, (index) => _dotIndicator(index)),
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
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                },
              ),
            ],
          );
  }

  @override
  void initState() {
    super.initState();
    _setSeenOnboard();
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
                                children: const [
                                  Image(
                                    image: AssetImage("assets/images/logo.png"),
                                    height: 100,
                                  ),
                                  SizedBox(
                                    height: 50,
                                  )
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
                          right: 30,
                          bottom: 15,
                          left: 30,
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
                            )
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
                  _getWidgetButtonNavigationBar(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
