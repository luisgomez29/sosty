class OnBoarding {
  final String title;
  final String image;

  OnBoarding({
    required this.title,
    required this.image,
  });
}

List<OnBoarding> onBoardingContents = [
  OnBoarding(
    title: "WELCOME",
    image: "assets/images/onboarding_img_1.jpg",
  ),
  OnBoarding(
    title: "WELCOME_1",
    image: "assets/images/onboarding_img_2.jpg",
  ),
  OnBoarding(
    title: 'WELCOME_3',
    image: "assets/images/onboarding_img_3.jpg",
  ),
];
