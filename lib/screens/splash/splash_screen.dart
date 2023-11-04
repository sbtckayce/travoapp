import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '/config/app_router_name.dart';
import '/utils/variable_const.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToOnBoardingScreen();
  }

  navigateToOnBoardingScreen() {
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? checkFirstTime = prefs.getString(VariableConst.checkFirstTime);
        if (checkFirstTime == null) {
        
          if (context.mounted) context.goNamed(AppRouterName.onBoarding);
        } else {
          if (context.mounted) context.goNamed(AppRouterName.auth);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: SvgPicture.asset(
              'assets/images/splash.svg',
              fit: BoxFit.cover,
            )));
  }
}
