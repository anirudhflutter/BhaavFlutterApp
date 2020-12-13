import 'dart:io';

import 'package:bhaav/Common/Services.dart';
import 'package:bhaav/Common/constants.dart';
import 'package:bhaav/Common/langString.dart';
import 'package:bhaav/firebaseauth/firebase/auth/phone_auth/verify.dart';
import 'package:bhaav/firebaseauth/providers/phone_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ProgressDialog pr;
  bool isLoading = false;
  TextEditingController edtMobileController = new TextEditingController();
  String phoneNo;
  String smsOTP;
  String verificationId;
  String errorMessage = '';
  FirebaseAuth _auth = FirebaseAuth.instance;
  int currentLoading = 0;
  bool userfound = false;

  @override
  void initState() {
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
        message: "Please Wait",
        borderRadius: 10.0,
        progressWidget: Container(
          padding: EdgeInsets.all(15),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(appPrimaryMaterialColor),
          ),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: TextStyle(
            color: Colors.red, fontSize: 17.0, fontWeight: FontWeight.w600));
    // TODO: implement initState
    super.initState();
  }

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Error"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: "scaffold-get-phone");

  _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text('$text'),
    );
//    if (mounted) Scaffold.of(context).showSnackBar(snackBar);
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  startPhoneAuth() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(mobileNumber, edtMobileController.text);
    final phoneAuthDataProvider =
        Provider.of<PhoneAuthDataProvider>(context, listen: false);
    phoneAuthDataProvider.loading = true;
    bool validPhone = await phoneAuthDataProvider.instantiate(
        phoneNumberField: edtMobileController,
        dialCode: "+91",
        onCodeSent: () {
          print("startedphoneauth");
          Navigator.of(context).pushReplacement(CupertinoPageRoute(
              builder: (BuildContext context) =>
                  PhoneAuthVerify(register: true)));
        },
        onFailed: () {
          _showSnackBar(phoneAuthDataProvider.message);
        },
        onError: () {
          _showSnackBar(phoneAuthDataProvider.message);
        });
    if (!validPhone) {
      phoneAuthDataProvider.loading = false;
      _showSnackBar("Oops! Number seems invaild");
      return;
    }
  }

  checkUser() async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        pr.show();
        setState(() {
          isLoading = true;
        });
        Services.GetAllUsers().then((data) async {
          if (data.length > 0) {
            pr.hide();
            setState(() {
              isLoading = false;
            });
            pr.hide();
            for (int i = 0; i < data.length; i++) {
              if (edtMobileController.text == data[i]["mobile"]) {
                userfound = true;
                break;
              }
            }
            if (userfound) {
              print("yes user found");
              startPhoneAuth();
            } else {
              showMsg(
                  "This mobile number is not registerd please register first");
            }
          }
        }, onError: (e) {
          pr.hide();
          showMsg("Try Again.");
        });
      } else {
        setState(() {
          isLoading = false;
        });
        pr.hide();
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      showMsg("No Internet Connection.");
    }
  }

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
              Navigator.of(context)
                  .pushReplacementNamed('/AuthenticationScreen');
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
                              controller: edtMobileController,
                              keyboardType: TextInputType.number,
                            )),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: InkWell(
                            //     onTap: () {
                            //       print("Send OTP to mobile No:");
                            //     },
                            //     child: Container(
                            //       width: 56,
                            //       height: 43,
                            //       decoration: BoxDecoration(
                            //           border: Border.all(
                            //             color: Colors.black87,
                            //             width: 1,
                            //           ),
                            //           borderRadius: BorderRadius.circular(8.0)),
                            //       child: Center(
                            //         child:
                            //             Image.asset('assets/images/send.png'),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        // SIZE_HEIGHT_NORMAL,
                        // SizedBox(
                        //   height: 45,
                        //   child: Stack(
                        //     overflow: Overflow.visible,
                        //     children: [
                        //       Container(
                        //         height: 45,
                        //         decoration: BoxDecoration(
                        //           border: Border.all(color: Colors.black),
                        //           borderRadius: BorderRadius.circular(8.0),
                        //         ),
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Row(
                        //             mainAxisAlignment:
                        //                 MainAxisAlignment.spaceEvenly,
                        //             children: [
                        //               SizedBox(
                        //                 width: 25,
                        //                 child: TextField(
                        //                   style: TextStyle(
                        //                     fontFamily: 'Quick',
                        //                     fontSize: TextSize.FONT_HIGH,
                        //                     fontWeight: FontWeight.w700,
                        //                   ),
                        //                   textAlign: TextAlign.center,
                        //                   maxLength: 1,
                        //                   maxLines: 1,
                        //                   keyboardType: TextInputType.phone,
                        //                   decoration: InputDecoration(
                        //                     counterText: "",
                        //                     enabledBorder: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                     focusedBorder: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                     border: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 width: 25,
                        //                 child: TextField(
                        //                   style: TextStyle(
                        //                     fontFamily: 'Quick',
                        //                     fontSize: TextSize.FONT_HIGH,
                        //                     fontWeight: FontWeight.w700,
                        //                   ),
                        //                   textAlign: TextAlign.center,
                        //                   maxLength: 1,
                        //                   maxLines: 1,
                        //                   keyboardType: TextInputType.phone,
                        //                   decoration: InputDecoration(
                        //                     counterText: "",
                        //                     enabledBorder: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                     focusedBorder: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                     border: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 width: 25,
                        //                 child: TextField(
                        //                   style: TextStyle(
                        //                     fontFamily: 'Quick',
                        //                     fontSize: TextSize.FONT_HIGH,
                        //                     fontWeight: FontWeight.w700,
                        //                   ),
                        //                   textAlign: TextAlign.center,
                        //                   maxLength: 1,
                        //                   maxLines: 1,
                        //                   keyboardType: TextInputType.phone,
                        //                   decoration: InputDecoration(
                        //                     counterText: "",
                        //                     enabledBorder: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                     focusedBorder: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                     border: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 width: 25,
                        //                 child: TextField(
                        //                   style: TextStyle(
                        //                     fontFamily: 'Quick',
                        //                     fontSize: TextSize.FONT_HIGH,
                        //                     fontWeight: FontWeight.w700,
                        //                   ),
                        //                   textAlign: TextAlign.center,
                        //                   maxLength: 1,
                        //                   maxLines: 1,
                        //                   keyboardType: TextInputType.phone,
                        //                   decoration: InputDecoration(
                        //                     counterText: "",
                        //                     enabledBorder: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                     focusedBorder: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                     border: UnderlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                           color: COLOR.primaryColor,
                        //                           width: 2),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       Positioned(
                        //         top: -10,
                        //         left: 8,
                        //         child: Align(
                        //           alignment: Alignment.topLeft,
                        //           child: Text(
                        //             BaseLang.getOtp(),
                        //             style: TextStyle(
                        //                 backgroundColor: Colors.white),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SIZE_HEIGHT_NORMAL,
                        InkWell(
                          onTap: () {
                            checkUser();
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
