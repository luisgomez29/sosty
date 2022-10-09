class OnBoarding {
  final String title;
  final String image;
  final String description;

  OnBoarding({
    required this.title,
    required this.image,
    required this.description,
  });
}

List<OnBoarding> onBoardingContents = [
  OnBoarding(
    title: "Bienvenido",
    image: "assets/images/onboarding_img_1.jpg",
    description: "Con Sosty invierte y apoya proyectos regenerativos que cuiden el planeta, produzcan alimentos saludables y sean sostenibles para todos",
  ),
  OnBoarding(
    title: "Bienvenido",
    image: "assets/images/onboarding_img_2.jpg",
    description: "Es hora de cambiar la agricultura y ganadería convencional por una producción regenerativa para nuestro planeta",
  ),
  OnBoarding(
    title: 'Bienvenido',
    image: "assets/images/onboarding_img_3.jpg",
    description: "Ayudar es sostenibilidad pero ayudar y ganar es Sosty",
  ),
];
