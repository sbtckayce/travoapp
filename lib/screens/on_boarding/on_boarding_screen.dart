import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/config/app_router_name.dart';
import '../../models/on_boarding/on_boarding_model.dart';
import '/utils/variable_const.dart';

import '../../widgets/widgets.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController pageController = PageController(initialPage: 0);
  // int pageIndex = 0;
  ValueNotifier<int> pageIndex = ValueNotifier(0);
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  navigateToLoginScreen() async {
    context.goNamed(AppRouterName.auth);
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString(VariableConst.checkFirstTime, 'true');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: ValueListenableBuilder(
          valueListenable: pageIndex,
          builder: (context, value, child) {
            return Column(
            children: [
              Flexible(
                  flex: 9,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: onBoadings.length,
                    onPageChanged: (value) {
                      pageIndex.value=value;
                    },
                    itemBuilder: (context, index) {
                      return OnBoardingItem(
                          index: index,
                          image: onBoadings[index].imageUrl,
                          title: onBoadings[index].title,
                          description: onBoadings[index].description);
                    },
                  ),
                ),
                
              
              Flexible(
                  flex: 1,
                  child: Row(
                    children: [
                      ...List.generate(
                          onBoadings.length,
                          (index) => DotIndicator(
                                isActive: index == pageIndex.value,
                              )),
                      const Spacer(),
                      pageIndex.value != onBoadings.length - 1
                          ? CustomButton(
                              text: 'Next',
                              onPressed: () {
                                pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);
                              },
                            )
                          : CustomButton(
                              text: 'Get Started',
                              onPressed: () {
                                navigateToLoginScreen();
                              },
                            )
                    ],
                  ))
            ],
          );
          },
        ),
      ),
    );
  }
}
