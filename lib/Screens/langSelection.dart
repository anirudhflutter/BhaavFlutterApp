import 'package:bhaav/constant/constants.dart';
import 'package:bhaav/constant/langString.dart';
import 'package:flutter/material.dart';

import 'authenticationScreen.dart';

class LangSelection extends StatefulWidget {
  LangSelection({Key key}) : super(key: key);
  static const String TAG = "/langSelection";
  @override
  _LangSelectionState createState() => _LangSelectionState();
}

class _LangSelectionState extends State<LangSelection> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: "fromSplashToLangOrHome",
                child: Container(
                  height: size.height * 0.35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24.0),
                        bottomRight: Radius.circular(24.0)),
                    color: Color(0xFFf26f3c),
                  ),
                  child: Row(
                    children: [
                      Opacity(
                        opacity: 0.1,
                        child: Image(
                          image: AssetImage('assets/images/translate.png'),
                          width: MediaQuery.of(context).size.width * 0.45,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, bottom: 25.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            BaseLang.getLanguageSelection(),
                            style: TextStyle(
                              fontFamily: 'Quick',
                              fontWeight: FontWeight.w500,
                              fontSize: TextSize.FONT_HIGH,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SIZE_HEIGHT_NORMAL,
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      BaseLang.getSelectLang(),
                      style: TextStyle(
                        fontFamily: 'Quick',
                        fontSize: TextSize.FONT_NORMAL,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      height: 3,
                      width: 70,
                      color: Color(0xFFf26f3c),
                    )
                  ],
                ),
              ),
              SIZE_HEIGHT_HIGH,
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          BaseLang.currentLang = LANG.MARATHI;
                          Navigator.of(context)
                              .pushNamed('/AuthenticationScreen');
                        });
                      },
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.orangeAccent,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orangeAccent,
                              blurRadius: 5.0,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                image: AssetImage('assets/images/mh_state.png'),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'marathi'.toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: 'Quick',
                                      fontSize: TextSize.FONT_HIGH,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SIZE_HEIGHT_NORMAL,
                    InkWell(
                      onTap: () {
                        setState(() {
                          BaseLang.currentLang = LANG.ENGLISH;
                          Navigator.of(context)
                              .pushNamed('/AuthenticationScreen');
                        });
                      },
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blueAccent,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueAccent,
                                blurRadius: 5.0,
                                offset: Offset(2, 2),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image(
                                image: AssetImage('assets/images/global.png'),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'english'.toUpperCase(),
                                  style: TextStyle(
                                      fontFamily: 'Quick',
                                      fontSize: TextSize.FONT_HIGH,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /* void goToNextScreen() {
    //if from SplashScreen go to LogIn Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AuthenticationScreen(),
      ),
    );
  }*/
}
