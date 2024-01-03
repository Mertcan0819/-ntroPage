import 'package:flutter/material.dart';
import 'package:introscreen/intro_screens/intro_page_1.dart';
import 'package:introscreen/intro_screens/intro_page_2.dart';
import 'package:introscreen/intro_screens/intro_page_3.dart';
import 'package:introscreen/screen/HomePage.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {


   final PageController _controller = PageController();

   bool onLostPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (value) {
              setState(() {
                onLostPage = (value == 2);
              });
            },
            children: const [
              IntroPage1(), 
              IntroPage2(), 
              IntroPage3(),  
            ],
          ), 

          Container(
            alignment: const Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                //skip
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text('skip'), 
                  ), 

                // indicator
                SmoothPageIndicator(
                  controller: _controller, 
                  count: 3
                  ),

                // next or done  
              onLostPage ?  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return const HomePage();
                      },));
                    },
                  child: const Text('done'),
                  )
                  : GestureDetector(
                    onTap: () {
                    _controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                  },
                  child: const Text('next'),
                  ),  
              ],
            ), 
              )
        ],
      ),
    );
  }
}