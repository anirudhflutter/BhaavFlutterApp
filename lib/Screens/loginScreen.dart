import 'package:bhaav/constant/constants.dart';
import 'package:bhaav/constant/langString.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: COLOR.primaryColor,
        centerTitle: true,
        elevation: 0,
        leading: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, right: 0, left: 10, bottom: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          BaseLang.getLogin(),
          style: TextStyle(
            fontFamily: 'Quick',
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            overflow: Overflow.visible,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade700,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextField(
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: BaseLang.getMobileNo(),
                                labelStyle: TextStyle(
                                    fontFamily: "Quick", color: Colors.black87),
                                contentPadding: EdgeInsets.all(12.0),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  print("Send OTP to mobile No:");
                                },
                                child: Container(
                                  width: 56,
                                  height: 43,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black87,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0)),
                                  child: Center(
                                    child:
                                        Image.asset('assets/images/send.png'),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SIZE_HEIGHT_NORMAL,
                        SizedBox(
                          height: 45,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              Container(
                                height: 45,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 25,
                                        child: TextField(
                                          style: TextStyle(
                                            fontFamily: 'Quick',
                                            fontSize: TextSize.FONT_HIGH,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          maxLines: 1,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                        child: TextField(
                                          style: TextStyle(
                                            fontFamily: 'Quick',
                                            fontSize: TextSize.FONT_HIGH,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          maxLines: 1,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                        child: TextField(
                                          style: TextStyle(
                                            fontFamily: 'Quick',
                                            fontSize: TextSize.FONT_HIGH,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          maxLines: 1,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 25,
                                        child: TextField(
                                          style: TextStyle(
                                            fontFamily: 'Quick',
                                            fontSize: TextSize.FONT_HIGH,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.center,
                                          maxLength: 1,
                                          maxLines: 1,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: COLOR.primaryColor,
                                                  width: 2),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: -10,
                                left: 8,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    BaseLang.getOtp(),
                                    style: TextStyle(
                                        backgroundColor: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SIZE_HEIGHT_NORMAL,
                        InkWell(
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
                              child:
                                  Image.asset('assets/images/check-circle.png'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -50,
                child: SizedBox(
                  height: 98,
                  width: 98,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(2, 2)),
                      ],
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
