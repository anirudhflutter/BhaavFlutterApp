import 'dart:io';

import 'package:bhaav/Common/Services.dart';
import 'package:bhaav/Common/constants.dart';
import 'package:bhaav/Common/langString.dart';
import 'package:bhaav/Components/ProductComponent.dart';
import 'package:bhaav/Screens/priceDetailScreen.dart';
import 'package:bhaav/Screens/priceScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

double _value = 10;

class _HomeScreenState extends State<HomeScreen> {
  ProgressDialog pr;
  bool isLoading = false;
  List GetAllProductsData = [], GetStatesData = [];

  @override
  void initState() {
    GetAllProducts();
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

  _showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text(
        "cancel",
        style: TextStyle(fontSize: 17),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = FlatButton(
      child: Text("continue", style: TextStyle(fontSize: 17)),
      onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();
        print("mobileNoVerification");
        print(mobileNoVerification);
        Navigator.pushNamedAndRemoveUntil(
            context, '/LoginScreen', (route) => false);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure want to Logout!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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

  List SearchData = [];

  GetAllProducts() async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        pr.show();
        setState(() {
          isLoading = true;
        });
        Services.GetAllProducts().then((data) async {
          pr.hide();
          if (data.Data.length > 0) {
            Fluttertoast.showToast(
                msg: "${data.Message}",
                backgroundColor: Colors.red,
                gravity: ToastGravity.TOP,
                toastLength: Toast.LENGTH_SHORT);
            setState(() {
              isLoading = false;
              GetAllProductsData = data.Data;
            });
          } else {
            showMsg("${data.Message}");
          }
        }, onError: (e) {
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
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 150,
              color: COLOR.primaryColor.withOpacity(0.8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 50),
                    child: Container(
                      height: 73,
                      width: 73,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/farmer.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 85.0, left: 10),
                    child: Text(
                      BaseLang.getTypeToSearch(),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Quick',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                print("Track Sells");
              },
              title: Text(
                'Track Sells',
                style: TextStyle(
                    fontFamily: 'Quick',
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ),
              leading: Image.asset('assets/images/shipping.png'),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                print("Sell History");
              },
              title: Text(
                'Sell History',
                style: TextStyle(
                    fontFamily: 'Quick',
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ),
              leading: Image.asset('assets/images/history.png'),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            ListTile(
              onTap: () {
                print("Help Question");
              },
              title: Text(
                'Support',
                style: TextStyle(
                    fontFamily: 'Quick',
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ),
              leading: Image.asset('assets/images/help_ques.png'),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: () {},
              child: ListTile(
                onTap: () {
                  _showAlertDialog(context);
                  print("Logout");
                },
                title: Text(
                  'Logout',
                  style: TextStyle(
                      fontFamily: 'Quick',
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ),
                leading: Image.asset('assets/images/logout.png'),
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
      appBar: AppBar(
          brightness: Brightness.dark,
          backgroundColor: COLOR.primaryColor,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Home",
            // BaseLang.getLogin(),
            style: TextStyle(
              fontFamily: 'Quick',
              color: Colors.white,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white)),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 5),
              child: Text(
                "Area to be searched",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: Colors.red[700],
                inactiveTrackColor: Colors.red[100],
                trackShape: RoundedRectSliderTrackShape(),
                trackHeight: 4.0,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                thumbColor: Colors.redAccent,
                overlayColor: Colors.red.withAlpha(32),
                overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                tickMarkShape: RoundSliderTickMarkShape(),
                activeTickMarkColor: Colors.red[700],
                inactiveTickMarkColor: Colors.red[100],
                valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                valueIndicatorColor: Colors.redAccent,
                valueIndicatorTextStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: Slider(
                value: _value,
                min: 0,
                max: 100,
                divisions: 10,
                label: '$_value' + 'm',
                onChanged: (value) {
                  setState(
                    () {
                      _value = value;
                    },
                  );
                },
              ),
            ),
            SIZE_HEIGHT_LOW,
            Padding(
              padding: const EdgeInsets.only(left: 6.0, right: 6),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Nearest Mandi Name",
                  isDense: true,
                  labelText: "My Location",
                  //BaseLang.getFullName(),
                  labelStyle:
                      TextStyle(fontFamily: "Quick", color: COLOR.primaryColor),
                  contentPadding: EdgeInsets.all(12.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
              child: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        enabled: true,
                        decoration: InputDecoration(
                          isDense: true,
                          labelText: BaseLang.getTypeToSearch(),
                          labelStyle: TextStyle(
                              fontFamily: "Quick", color: Colors.black45),
                          contentPadding: EdgeInsets.all(12.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(color: Color(0xCCF07544)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(4.0)),
                            borderSide: BorderSide(color: Color(0xCCF07544)),
                          ),
                        ),
                        onChanged: (value) {
                          print("changed");
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: InkWell(
                        child: Image.asset(
                          'assets/images/search.png',
                          width: 30,
                          height: 25,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: ListView.builder(
                  itemCount: GetAllProductsData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PriceScreen(
                              eachProductId: GetAllProductsData[index]["_id"],
                              index: index,
                            ),
                          ),
                        );
                      },
                      child: ProductComponent(
                          GetAllProductsData: GetAllProductsData, index: index),
                    );
                  }),
            ))
          ],
        ),
      ),
    );
  }

  /* void goToNextScreen(screen) {
    //if from SplashScreen go to LogIn Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }*/
}
