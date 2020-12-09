import 'package:bhaav/screen/SalesHistoryScreen.dart';
import 'package:bhaav/screen/authenticationScreen.dart';
import 'package:bhaav/screen/calculateIncomeScreen.dart';
import 'package:bhaav/screen/homeScreen.dart';
import 'package:bhaav/screen/langSelection.dart';
import 'package:bhaav/screen/loginScreen.dart';
import 'package:bhaav/screen/priceDetailScreen.dart';
import 'package:bhaav/screen/priceScreen.dart';
import 'package:bhaav/screen/signupScreen.dart';
import 'package:bhaav/screen/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bhaav',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: {
          '/': (context) => SplashScreen(),
          '/LangSelection': (context) => LangSelection(),
          '/LoginScreen': (context) => LoginScreen(),
          '/SignupScreen': (context) => SignupScreen(),
          '/AuthenticationScreen': (context) => AuthenticationScreen(),
          '/LoginScreen': (context) => LoginScreen(),
          '/SignupScreen': (context) => SignupScreen(),
          '/HomeScreen': (context) => HomeScreen(),
          '/PriceScreen': (context) => PriceScreen(),
          '/PriceDetailScreen': (context) => PriceDetailScreen(),
          '/calculateIncomeScreen': (context) => calculateIncomeScreen(),
          '/SalesHistoryScreen': (context) => SalesHistoryScreen(),
        });
  }
}
