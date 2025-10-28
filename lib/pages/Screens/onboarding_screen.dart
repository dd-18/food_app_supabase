import 'package:flutter/material.dart';
import 'package:food_app_supabase/Core/Utils/consts.dart';

import '../../Core/models/on_bording_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // for image background
            Container(
              height: size.height,
              width: size.width,
              color: imageBackground,
              child: Image.asset(
                'assets/food-delivery/food pattern.png',
                color: imageBackground2,
                repeat: ImageRepeat.repeatY,
              ),
            ),
            Positioned(
              top: -80,
              left: 0,
              right: 0,
              child: Image.asset('assets/food-delivery/chef.png'),
            ),
            Positioned(
              top: 80,
              right: 30,
              child: Image.asset('assets/food-delivery/leaf.png', width: 80),
            ),
            Positioned(
              top: 300,
              right: 10,
              child: Image.asset('assets/food-delivery/chili.png', width: 80),
            ),
            Positioned(
              top: 290,
              left: 0,
              child: Image.asset(
                'assets/food-delivery/ginger.png',
                height: 90,
                width: 90,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 75),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 180,
                        child: PageView.builder(
                          controller: pageController,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: data[index]['title1'],
                                        style: TextStyle(color: Colors.black),
                                      ),
                                      TextSpan(
                                        text: data[index]['title2'],
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  data[index]['description']!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Row(
                        children: List.generate(
                          data.length,
                          (index) => AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            width: currentPage == index ? 20 : 10,
                            height: 10,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: currentPage == index
                                  ? Colors.orange
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
