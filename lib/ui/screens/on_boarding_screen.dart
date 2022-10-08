import 'package:flutter/material.dart';
import 'package:sosty_app/ui/helpers/OnBoarding.dart';
import 'package:sosty_app/ui/helpers/SizeConfig.dart';
import 'package:sosty_app/ui/screens/login_screen.dart';
import 'package:sosty_app/ui/components/buttons/text_button_full_width.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  AnimatedContainer _dotIndicator(index) {
    return AnimatedContainer(
      height: 12,
      width: 12,
      margin: const EdgeInsets.only(right: 5),
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.lightGreen : Colors.black54,
        shape: BoxShape.circle,
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print("SIZE => ${SizeConfig.screenHeight}");
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
                    Image(
                      image: AssetImage(onBoardingContents[index].image),
                      height: SizeConfig.screenHeight! * 60 / 100,
                      fit: BoxFit.fill,
                    ),
                    Container(
                      width: SizeConfig.screenWidth,
                      decoration: const BoxDecoration(),
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          Text(
                            onBoardingContents[index].title,
                            style: Theme.of(context).textTheme.headline1,
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Con Sosty invierte y apoya proyectos regenerativos que cuiden el planeta, produzcan alimentos saludables y sean sostenibles para todos",
                            style: Theme.of(context).textTheme.bodyText1,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _currentPage == onBoardingContents.length - 1
                      ? TextButtonFullWidth(
                          text: "Iniciar",
                          bgColor: Colors.lightGreen,
                          onPressed: _goToLoginScreen,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // style: Theme.of(context).textTheme.bodyText2,
                            TextButton(
                              onPressed: _goToLoginScreen,
                              child: Text(
                                "Omitir",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                              ),
                            ),
                            Row(
                              children: List.generate(onBoardingContents.length,
                                  (index) => _dotIndicator(index)),
                            ),
                            IconButton(
                              icon: const Icon(Icons.arrow_forward_sharp),
                              iconSize: 32.0,
                              selectedIcon: const Icon(Icons.settings),
                              style: IconButton.styleFrom(
                                backgroundColor: Colors.lightGreen,
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
