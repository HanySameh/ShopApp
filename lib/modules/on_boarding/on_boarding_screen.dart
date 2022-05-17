import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/network/local/cache_helper.dart';
import '../../shared/components/component.dart';
import '../../shared/style/colors.dart';
import '../login/shop_login_screen.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardingController = PageController();
  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/page2.jpeg',
      title: 'Page One Screen',
      body: 'page one body',
    ),
    BoardingModel(
      image: 'assets/images/page4.png',
      title: 'Page Tow Screen',
      body: 'page tow body',
    ),
    BoardingModel(
      image: 'assets/images/page5.jpg',
      title: 'Page Three Screen',
      body: 'page three body',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              onSubmit(context);
            },
            child: const Text('SKIP'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: boardingController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: defaultColor,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      onSubmit(context);
                    } else {
                      boardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 750,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void onSubmit(context) {
  CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
    if (value) {
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        const SizedBox(
          height: 30.0,
        ),
        Text(
          model.title,
          style: const TextStyle(
            fontSize: 24.0,
            color: Colors.black,
            //fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15.0,
        ),
        Text(
          model.body,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
