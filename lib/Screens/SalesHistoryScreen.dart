import 'dart:io';

import 'package:bhaav/Common/Services.dart';
import 'package:bhaav/Common/constants.dart';
import 'package:bhaav/Components/SalesHistoryComponent.dart';
import 'package:bhaav/Screens/homeScreen.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SalesHistoryScreen extends StatefulWidget {
  String language="";
  SalesHistoryScreen({this.language});
  @override
  _SalesHistoryScreenState createState() => _SalesHistoryScreenState();
}

class _SalesHistoryScreenState extends State<SalesHistoryScreen> {
  ProgressDialog pr;

  @override
  void initState() {
    GetLocalData();
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

  String farmerid = "";

  GetLocalData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    farmerid = sharedPreferences.getString(FarmerId);
    getFarmerProduct(farmerid);
  }

  List getFarmerSalesHistory = [];


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

  getFarmerProduct(String farmerid) async {
    try {
      print("farmerid");
      print(farmerid);
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        pr.show();
        var body = {
          "farmerId": farmerid,
        };
        Services.getFarmerProduct(body).then((data) async {
          pr.hide();
          if (data.length > 0) {
            setState(() {
              getFarmerSalesHistory = data;
            });
          } else {
            // showMsg("");
          }
        }, onError: (e) {
          showMsg("Try Again.");
        });
      } else {
        pr.hide();
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      showMsg("No Internet Connection.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Navigator.of(context).pushReplacementNamed('/HomeScreen'),
      child: Scaffold(
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
                  Navigator.of(context).pushReplacementNamed('/HomeScreen');
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              "Sales/History",
              //  BaseLang.getPrice(),
              style: TextStyle(
                fontFamily: 'Quick',
                color: Colors.white,
              ),
            ),
          ),
          body: getFarmerSalesHistory.length == 0
              ? Center(
            child:
                  Text(
                    "No Data Found",
                  ),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  // scrollDirection: Axis.horizontal,
                  itemCount: getFarmerSalesHistory.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SalesHistoryComponent(
                      getFarmerSalesHistory: getFarmerSalesHistory[index],
                    );
                  })),
    );
  }
}
