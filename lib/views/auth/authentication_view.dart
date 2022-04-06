import 'package:flutter/material.dart';
import 'package:tyba_flutter_challenge/utils/export_utils.dart';
import 'package:tyba_flutter_challenge/views/export_views.dart';
import 'package:tyba_flutter_challenge/widgets/export_widgets.dart';

class GoToPage {
  static const int home = 0;
  static const int login = 1;
  static const int register = 2;
}

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {

  final PageController _pageController = PageController(initialPage: GoToPage.home);

  void _switchPage(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: backgroundColor,
        body: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: SizedBox(
            height: screenSize.height * 0.80,
            width: screenSize.width * 0.90,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                        tybaSingleLogo,
                        width: 400, height: 400,
                        fit: BoxFit.contain
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 45.0),
                      child: const WelcomeText()
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            _switchPage(GoToPage.login);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Iniciar Sesión', style: TextStyle(fontSize: 20.0))
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            primary: secondaryColor,
                            elevation: 0
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (){
                            _switchPage(GoToPage.register);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Regístrate', style: TextStyle(fontSize: 20.0))
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                            primary: secondaryColor,
                            elevation: 0
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60.0)
                  ],
                ),
                LoginView(
                  goBack: (){
                    _switchPage(GoToPage.home);
                  }
                ),
                RegisterView(
                  goBack: (){
                    _switchPage(GoToPage.home);
                  }
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

