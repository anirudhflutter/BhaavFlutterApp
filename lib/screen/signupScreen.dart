import 'package:bhaav/constant/constants.dart';
import 'package:bhaav/constant/langString.dart';
import 'package:bhaav/screen/homeScreen.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: COLOR.primaryColor,
        centerTitle: true,
        elevation: 0,
        /*leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
            height: 60,
            width: 70,
            child: Image.asset('assets/images/ic_bhaav.png'),
          ),
        ),*/
        title: Text(
          BaseLang.getSignUp(),
          style: TextStyle(
            fontFamily: 'Quick',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //!TODO Add Picker
              //Image.file(),
              SIZE_HEIGHT_LOW,
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    print("Hello");
                  },
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                      image: DecorationImage(
                        image: AssetImage('assets/images/user.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              SIZE_HEIGHT_LOW,
              TextField(
                decoration: InputDecoration(
                  isDense: true,
                  labelText: BaseLang.getFullName(),
                  labelStyle:
                      TextStyle(fontFamily: "Quick", color: COLOR.primaryColor),
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Color(0xFF707070)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Color(0xFF707070)),
                  ),
                ),
              ),
              SIZE_HEIGHT_LOW,
              TextField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  isDense: true,
                  labelText: BaseLang.getMobileNo(),
                  labelStyle:
                      TextStyle(fontFamily: "Quick", color: COLOR.primaryColor),
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Color(0xFF707070)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Color(0xFF707070)),
                  ),
                ),
              ),
              SIZE_HEIGHT_LOW,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: BaseLang.getLocation(),
                        labelStyle: TextStyle(
                            fontFamily: "Quick", color: COLOR.primaryColor),
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Color(0xFF707070)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Color(0xFF707070)),
                        ),
                      ),
                    ),
                  ),
                  SIZE_HEIGHT_LOW,
                  Container(
                    child: Image.asset('assets/images/location.png'),
                  ),
                ],
              ),
              SIZE_HEIGHT_HIGH,
              Row(
                children: [
                  Text(
                    BaseLang.getLandSizeOwned(),
                  ),
                  SIZE_HEIGHT_LOWEST,
                  SizedBox(
                    width: 70,
                    height: 35,
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'Quick',
                        fontSize: TextSize.FONT_HIGH,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                      maxLength: 4,
                      maxLines: 1,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        counterText: "",
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF707070), width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF707070), width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF707070), width: 1),
                        ),
                      ),
                    ),
                  ),
                  SIZE_HEIGHT_LOWEST,
                  Text(
                    BaseLang.getBigha(),
                  ),
                ],
              ),
              SIZE_HEIGHT_LOW,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: BaseLang.getState(),
                        labelStyle: TextStyle(
                            fontFamily: "Quick", color: COLOR.primaryColor),
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Color(0xFF707070)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Color(0xFF707070)),
                        ),
                      ),
                    ),
                  ),
                  SIZE_HEIGHT_LOWEST,
                  Container(
                    child: Image.asset('assets/images/ic_down.png'),
                  ),
                ],
              ),
              SIZE_HEIGHT_LOW,
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: BaseLang.getDistrict(),
                        labelStyle: TextStyle(
                            fontFamily: "Quick", color: COLOR.primaryColor),
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Color(0xFF707070)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Color(0xFF707070)),
                        ),
                      ),
                    ),
                  ),
                  SIZE_HEIGHT_LOWEST,
                  Container(
                    child: Image.asset('assets/images/ic_down.png'),
                  ),
                ],
              ),
              SIZE_HEIGHT_LOW,
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/HomeScreen', (route) => false);
                  },
                  child: Container(
                    height: 50,
                    width: 65,
                    decoration: BoxDecoration(
                      border: Border.all(color: COLOR.primaryColor),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        BaseLang.getSubmit(),
                        style: TextStyle(
                          fontFamily: 'Quick',
                          color: COLOR.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void goToNextScreen(screen) {
    //if from SplashScreen go to LogIn Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
