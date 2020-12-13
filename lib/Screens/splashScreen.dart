import 'dart:async';

import 'package:bhaav/Common/constants.dart';
import 'package:bhaav/Screens/langSelection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  /*SplashScreen({Key key}) : super(key: key);
  static const String TAG = "/";*/
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    //WidgetsBinding.instance.addPostFrameCallback((_) => callNextWidget());
    return Scaffold(
      body: Container(
        color: Color(0xFFf26f3c),
        child: Center(
          child: Hero(
            tag: "fromSplashToLangOrHome",
            child: SizedBox(
                width: 200,
                child: Image(
                  image: AssetImage('assets/images/ic_bhaav.png'),
                )),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    Timer(Duration(seconds: 3), () async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      var mobileNumber = sharedPreferences.getString(mobileNoVerification);
      print("mobilenumber on splash screen");
      print(mobileNumber);
      if (mobileNumber != null) {
        Navigator.of(context).pushReplacementNamed('/HomeScreen');
      } else {
        Navigator.of(context).pushReplacementNamed('/LangSelection');
      }
    });
  }
}
