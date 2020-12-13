import 'dart:io';

import 'package:bhaav/Common/Services.dart';
import 'package:bhaav/Common/constants.dart';
import 'package:bhaav/Common/langString.dart';
import 'package:bhaav/firebaseauth/firebase/auth/phone_auth/verify.dart';
import 'package:bhaav/firebaseauth/providers/phone_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  ProgressDialog pr;
  bool isLoading = false;
  TextEditingController edtMobileController = new TextEditingController();
  TextEditingController edtNameController = new TextEditingController();
  TextEditingController edtStateController = new TextEditingController();
  TextEditingController edtDistrictController = new TextEditingController();
  TextEditingController edtLocationController = new TextEditingController();
  TextEditingController edtLandSizeOwnedController =
      new TextEditingController();
  List GetAllUsersData = [];
  int checkifuserfound = 0;
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
            color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w600));
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
    sharedPreferences.setString(Nameonsignup, edtNameController.text);
    sharedPreferences.setString(Locationonsignup, edtLocationController.text);
    sharedPreferences.setString(
        Landsizeownedonsignup, edtLandSizeOwnedController.text);
    sharedPreferences.setString(Stateonsignup, edtStateController.text);
    sharedPreferences.setString(Districtonsignup, edtDistrictController.text);

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
            for (int i = 0; i < data.length; i++) {
              if (edtMobileController.text == data[i]["mobile"]) {
                userfound = true;
                break;
              }
            }
            if (userfound) {
              showMsg("This mobile number is already registered please login");
            } else {
              print("user not found");
              startPhoneAuth();
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
      key: scaffoldKey,
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
                controller: edtNameController,
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
                controller: edtMobileController,
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
                      controller: edtLocationController,
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
                      controller: edtLandSizeOwnedController,
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
                      controller: edtStateController,
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
                      controller: edtDistrictController,
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
                    if (edtMobileController.text == "" ||
                        edtMobileController.text.length != 10 ||
                        edtNameController.text == "" ||
                        edtLocationController.text == "" ||
                        edtLandSizeOwnedController.text == "" ||
                        edtStateController.text == "" ||
                        edtDistrictController.text == "") {
                      showMsg("Please try again");
                    } else {
                      checkUser();
                    }
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
