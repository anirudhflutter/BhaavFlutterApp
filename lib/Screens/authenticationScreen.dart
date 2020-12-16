import 'package:bhaav/Common/constants.dart';
import 'package:bhaav/Common/langString.dart';
import 'package:bhaav/Screens/loginScreen.dart';
import 'package:bhaav/Screens/signupScreen.dart';
import 'package:flutter/material.dart';

class AuthenticationScreen extends StatefulWidget {
  String LanguageSelected="";
AuthenticationScreen({this.LanguageSelected});
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: COLOR.primaryColor,
        centerTitle: true,
        elevation: 0,
        title: SizedBox(
          height: 56,
          width: 56,
          child: Image.asset('assets/images/ic_bhaav.png'),
        ),
        leading: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, right: 0, left: 10, bottom: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/LangSelection');
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                goToNextScreen(LoginScreen());
              },
              child: Container(
                height: 146,
                width: 151,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: COLOR.primaryColor,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 98,
                        width: 98,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: COLOR.primaryColor,
                          ),
                          child: Center(
                            child: SizedBox(
                              height: 75,
                              child: Image.asset(
                                'assets/images/farmer.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(
                          BaseLang.getLogin(),
                          style: TextStyle(
                            fontSize: TextSize.FONT_NORMAL,
                            fontFamily: 'Quick',
                          )),
                    ],
                  ),
                ),
              ),
            ),
            SIZE_HEIGHT_NORMAL,
            InkWell(
              onTap: () {
                goToNextScreen(SignupScreen());
              },
              child: Container(
                height: 146,
                width: 151,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: COLOR.primaryColor,
                      blurRadius: 5,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 98,
                        width: 98,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: COLOR.primaryColor,
                          ),
                          child: Center(
                            child: SizedBox(
                              height: 75,
                              child: Image.asset(
                                'assets/images/farmer-modern.png',
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(BaseLang.getSignUp(),
                          style: TextStyle(
                            fontSize: TextSize.FONT_NORMAL,
                            fontFamily: 'Quick',
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void goToNextScreen(Screens) {
    //if from SplashScreen go to LogIn Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Screens,
      ),
    );
  }
}
