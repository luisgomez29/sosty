import 'package:flutter/material.dart';
import 'package:sosty_app/ui/components/buttons/text_button_full_width.dart';
import 'package:sosty_app/ui/config/theme/light_theme.dart';
import 'package:sosty_app/ui/helpers/OnBoarding.dart';
import 'package:sosty_app/ui/helpers/SizeConfig.dart';
import 'package:sosty_app/ui/screens/login_screen.dart';

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
        color: _currentPage == index
            ? Theme
            .of(context)
            .primaryColor
            : secondaryColor,
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
                itemBuilder: (context, index) =>
                    Column(
                      children: [
                        ClipPath(
                          clipper: WaveClip(),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 60 / 100,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      onBoardingContents[index].image,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height:
                                MediaQuery
                                    .of(context)
                                    .size
                                    .height * 60 / 100,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: FractionalOffset.topCenter,
                                    end: FractionalOffset.bottomCenter,
                                    colors: [
                                      Colors.grey.withOpacity(0.0),
                                      Theme
                                          .of(context)
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
                                      image: AssetImage(
                                          "assets/images/logo.png"),
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
                        Transform.translate(
                          offset: const Offset(0.0, 0.0),
                          child: Container(
                            width: SizeConfig.screenWidth,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  onBoardingContents[index].title,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .headline1,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  onBoardingContents[index].description,
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1,
                                )
                              ],
                            ),
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
                    bgColor: Theme
                        .of(context)
                        .primaryColor,
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
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText2,
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
                          backgroundColor: Theme
                              .of(context)
                              .primaryColor,
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

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final lowPoint = size.height - 20;
    final highPoint = size.height - 40;
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
