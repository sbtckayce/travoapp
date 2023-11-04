class OnBoardingModel {
  final String imageUrl;
  final String title;
  final String description;

  OnBoardingModel(
      {required this.imageUrl, required this.title, required this.description});
}

List<OnBoardingModel> onBoadings = [
  OnBoardingModel(
      imageUrl: 'assets/images/onBoarding1.png',
      title: 'Book a flight',
      description:
          'Found a flight that matches your destination and schedule? Book it instantly.'),
  OnBoardingModel(
      imageUrl: 'assets/images/onBoarding2.png',
      title: 'Find a hotel room',
      description:
          'Select the day, book your room. We give you the best price.'),
  OnBoardingModel(
      imageUrl: 'assets/images/onBoarding3.png',
      title: 'Enjoy your trip',
      description:
          'Easy discovering new places and share these between your friends and travel together.')
];
