import 'package:flutter/material.dart';
import 'package:halalapp/components/my_button.dart';
import 'package:halalapp/constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        _pageIndex = index;
                      });
                    },
                    itemCount: demo_data.length,
                    controller: _pageController,
                    itemBuilder: (context, index) => OnboardingContent(
                        imagePath: demo_data[index].imagePath,
                        text: demo_data[index].title,
                        description: demo_data[index].description)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ...List.generate(
                      demo_data.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(left: 7.0),
                        child: DotIndicator(
                          isActive: index == _pageIndex,
                        ),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_pageController.page == demo_data.length - 1) {
                            Navigator.pushNamed(context, "/login");
                          } else {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: 300),
                                curve: Curves.easeInOut);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          backgroundColor: kPrimaryColor,
                        ),
                        child: Icon(Icons.arrow_right_alt),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isActive ? 15 : 6,
      width: 4,
      decoration: BoxDecoration(
        color: isActive ? kPrimaryColor : Colors.grey.shade400,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class Onboard {
  final String imagePath, title, description;
  Onboard(
      {required this.imagePath,
      required this.title,
      required this.description});
}

final List<Onboard> demo_data = [
  Onboard(
    imagePath: "assets/undraw_tourist_map.png",
    title: "Halal all around",
    description: "There are so many amazing halal places\n in New York City!",
  ),
  Onboard(
    imagePath: "assets/undraw_Tasting.png",
    title: "Influencers all around",
    description:
        "And there are so many different influencers, websites, and more \n that show you the coolest halal places in NYC",
  ),
  Onboard(
    imagePath: "assets/undraw_Eating_together.png",
    title: "All in one place",
    description:
        "Our goal is to put all the amazing halal places in one place. \nFind and explore neighborhood stores around you! \n Let's get started!",
  ),
];

class OnboardingContent extends StatelessWidget {
  const OnboardingContent({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.description,
  }) : super(key: key);

  final String imagePath;
  final String text;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity),
        Spacer(),
        Image.asset(
          imagePath,
          height: 250,
        ),
        Spacer(),
        Text(
          text,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        Spacer(),
      ],
    );
  }
}
