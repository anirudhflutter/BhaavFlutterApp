import 'package:bhaav/Screens/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';













import 'Screens/SalesHistoryScreen.dart';
import 'Screens/authenticationScreen.dart';
import 'Screens/calculateIncomeScreen.dart';
import 'Screens/homeScreen.dart';
import 'Screens/langSelection.dart';
import 'Screens/loginScreen.dart';
import 'Screens/priceDetailScreen.dart';
import 'Screens/priceScreen.dart';
import 'Screens/signupScreen.dart';
import 'firebaseauth/providers/countries.dart';
import 'firebaseauth/providers/phone_auth.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CountryProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PhoneAuthDataProvider(),
        ),
      ],
      child:MaterialApp(
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
                '/HomeScreen': (context) => HomeScreen(),
                '/AuthenticationScreen': (context) => AuthenticationScreen(),
                '/PriceScreen': (context) => PriceScreen(),
                '/PriceDetailScreen': (context) => PriceDetailScreen(),
                '/calculateIncomeScreen': (context) => calculateIncomeScreen(),
                '/SalesHistoryScreen': (context) => SalesHistoryScreen(),
              }),
    );
  }
}
