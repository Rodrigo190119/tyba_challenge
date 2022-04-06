import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tyba_flutter_challenge/utils/export_utils.dart';
import 'package:tyba_flutter_challenge/views/export_views.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: SizedBox(
        height: 300, width: 300,
        child: Image.asset(tybaTextLogo, fit: BoxFit.contain)),
      duration: 2500,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: splashColor,
      nextScreen: const AuthenticationView());
  }
}
