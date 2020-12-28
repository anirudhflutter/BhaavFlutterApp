import 'dart:io';

import 'package:bhaav/Common/Services.dart';
import 'package:bhaav/Common/constants.dart';
import 'package:bhaav/Screens/SalesHistoryScreen.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:location/location.dart' as loc;
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class calculateIncomeScreen extends StatefulWidget {
  Map individualProductData = {};
  String language = "";

  calculateIncomeScreen({this.individualProductData, this.language});

  @override
  _calculateIncomeScreenState createState() => _calculateIncomeScreenState();
}

class _calculateIncomeScreenState extends State<calculateIncomeScreen>
    with TickerProviderStateMixin {
  String _format = 'yyyy-MMMM-dd';
  DateTime _date = DateTime.now();
  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  TextEditingController date = TextEditingController();
  TextEditingController edtQuantityController = TextEditingController();

  void _showBirthDate() {
    DatePicker.showDatePicker(
      context,
      dateFormat: _format,
      initialDateTime: _date,
      locale: _locale,
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _date = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _date = dateTime;
          date.text = _date.toString().split(" ")[0];
        });
        print(_date);
      },
    );
  }

  ProgressDialog pr;

  @override
  void initState() {
    GetLocalData();
    getUserLocation();
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

  loc.LocationData currentLocation;
  String address = "";
  double Lat = 0.0, Long = 0.0;
  String myaddress = "", farmerId = "";

  GetLocalData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    farmerId = sharedPreferences.getString(FarmerId);
  }

  getUserLocation() async {
    loc.LocationData myLocation;
    String error;
    loc.Location location = new loc.Location();
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
    }
    currentLocation = myLocation;
    Lat = currentLocation.latitude;
    Long = currentLocation.longitude;
    print("lat");
    print(Lat);
    print("Long");
    print(Long);
    final coordinates =
        new Coordinates(myLocation.latitude, myLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    getMandiDistance(widget.individualProductData["mandiId"]["_id"],
        Lat.toString(), Long.toString());
    setState(() {
      myaddress = '${first.addressLine}';
    });
    print('${first.addressLine}, ${first.featureName},${first.thoroughfare}');
    return first;
  }

  double distance = 0.0;

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

  getMandiDistance(String mandiId, String lat, String long) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = {
          "mandiId": mandiId.toString(),
          "userLat": lat,
          "userLong": long
        };
        Services.getMandiDistance(body).then((data) async {
          pr.hide();
          if (data.length > 0) {
            distance = data["Distance"];
          } else {
            showMsg("");
          }
        }, onError: (e) {
          showMsg("Try Again.");
        });
      } else {
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      showMsg("No Internet Connection.");
    }
  }

  int total = 0;
  double travellingcost = 0.0;
  int quantity = 0;

  addProductForSale(
    String farmerId,
    String mandiId,
    String productId,
    int quantity,
    double farmerLat,
    double farmerLng,
    double totalCost,
    double profit,
  ) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = {
          "farmerId": farmerId.toString(),
          "mandiId": mandiId.toString(),
          "productId": productId.toString(),
          "qty": quantity,
          "farmerLat": Lat,
          "farmerLng": Long,
          "totalCost": travellingcost,
          "profit": profit
        };
        print(farmerId);
        print(mandiId);
        print(productId);
        print(quantity);
        print(Lat);
        print(Long);
        print(travellingcost);
        print(profit);

        Services.addProductForSale(body).then((data) async {
          pr.hide();
          if (data.length > 0) {
            Fluttertoast.showToast(
                msg: "Order Received Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            quantity = 0;
            Navigator.of(context).pushReplacementNamed('/SalesHistoryScreen');
          } else {
            // showMsg("");
          }
        }, onError: (e) {
          showMsg("Try Again.");
        });
      } else {
        showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      showMsg("No Internet Connection.");
    }
  }

  bool valuefirst = false;

  @override
  Widget build(BuildContext context) {
    print(total);
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
        title: widget.language == "Marathi"
            ? Text(
                "उत्पन्नाची गणना करा",
                //  BaseLang.getPrice(),
                style: TextStyle(
                  fontFamily: 'Quick',
                  color: Colors.white,
                ),
              )
            : Text(
                "Calculate Income",
                //  BaseLang.getPrice(),
                style: TextStyle(
                  fontFamily: 'Quick',
                  color: Colors.white,
                ),
              ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 5,
            ),
            Material(
              color: Colors.white,
              child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: new BubbleTabIndicator(
                    indicatorHeight: 43,
                    indicatorRadius: 6,
                    indicatorColor: COLOR.primaryColor,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  tabs: [
                    widget.language == "Marathi"
                        ? Tab(
                            child: Text(
                              "आता विक्री",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          )
                        : Tab(
                            child: Text(
                              "Sell Now",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                    widget.language == "Marathi"
                        ? Tab(
                            child: Text("नंतर विक्री",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16)))
                        : Tab(
                            child: Text("Sell Later",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16))),
                  ]),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SIZE_HEIGHT_LOW,
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 17.0, right: 17, top: 15),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Product Name",
                              isDense: true,
                              labelText: widget.language == "Marathi"
                                  ? "${widget.individualProductData["mandiId"]["MandiMarathiName"]}"
                                  : "${widget.individualProductData["mandiId"]["MandiName"]}",
                              //BaseLang.getFullName(),
                              labelStyle: TextStyle(
                                  fontFamily: "Quick",
                                  color: COLOR.primaryColor),
                              contentPadding: EdgeInsets.all(12.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SIZE_HEIGHT_LOW,
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 17.0, right: 17, top: 15),
                          child: TextFormField(
                            controller: edtQuantityController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: widget.language=="Marathi" ?
                              "प्रमाण प्रविष्ट करा" : "Enter Quantity",
                              isDense: true,
                              labelText: widget.language == "Marathi"
                                  ? "प्रमाण"
                                  : "Quantity",
                              labelStyle: TextStyle(
                                  fontFamily: "Quick",
                                  color: COLOR.primaryColor),
                              contentPadding: EdgeInsets.all(12.0),
                              suffixIcon: Container(
                                  width: 65,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              width: 1, color: Colors.grey))),
                                  child: Center(
                                    child: widget.language == "Marathi"
                                        ? Text(
                                            "क्विंटल",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            "Quintal",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              setState(() {
                                quantity = int.parse(value);
                                travellingcost =
                                    (60 * int.parse(value)) + (3 * distance);
                                total = widget
                                        .individualProductData["highestPrice"] *
                                    int.parse(value);
                              });
                            },
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 15, left: 8),
                        //   child: Row(
                        //     children: [
                        //       Padding(
                        //         padding:
                        //             const EdgeInsets.only(left: 20.0, top: 30),
                        //         child: Column(
                        //           children: [
                        //             Container(
                        //               decoration: BoxDecoration(
                        //                   color: Colors.grey,
                        //                   shape: BoxShape.circle),
                        //               height: 14,
                        //               width: 14,
                        //               // child: Text("data"),
                        //             ),
                        //             Container(
                        //               decoration: BoxDecoration(
                        //                   color: Colors.grey,
                        //                   shape: BoxShape.rectangle),
                        //               height: 85,
                        //               width: 2,
                        //               // child: Text("data"),
                        //             ),
                        //             Container(
                        //               decoration: BoxDecoration(
                        //                   color: COLOR.primaryColor,
                        //                   shape: BoxShape.circle),
                        //               height: 14,
                        //               width: 14,
                        //               // child: Text("data"),
                        //             )
                        //           ],
                        //         ),
                        //       ),
                        //       Column(
                        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Text(
                        //             myaddress.toString(),
                        //           ),
                        //           SizedBox(
                        //             height: MediaQuery.of(context).padding.top + 30,                                  ),
                        //           // Text(
                        //           //     "${widget.individualProductData["mandiId"]["location"]["completeAddress"]}",
                        //           //     ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.top + 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 50,
                                    margin: EdgeInsets.only(right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[400], width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${travellingcost.round()}",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -8,
                                    left: 12,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: widget.language == "Marathi"
                                          ? Text(
                                              "एकूण किंमत",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: COLOR.primaryColor,
                                                  backgroundColor:
                                                      Colors.white),
                                            )
                                          : Text(
                                              "Total Cost",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: COLOR.primaryColor,
                                                  backgroundColor:
                                                      Colors.white),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 50,
                                    margin: EdgeInsets.only(right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[400], width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "${(total - travellingcost).round()}",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    )),
                                  ),
                                  Positioned(
                                    top: -8,
                                    left: 12,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: widget.language == "Marathi"
                                          ? Text(
                                              "उत्पन्न",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: COLOR.primaryColor,
                                                  backgroundColor:
                                                      Colors.white),
                                            )
                                          : Text(
                                              "Income",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: COLOR.primaryColor,
                                                  backgroundColor:
                                                      Colors.white),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.top + 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (quantity == 0.0) {
                              widget.language == "Marathi"
                                  ? showMsg("कृपया प्रमाण प्रविष्ट करा")
                                  : showMsg("Please enter quantity");
                            } else {
                              addProductForSale(
                                farmerId,
                                widget.individualProductData["mandiId"]["_id"],
                                widget.individualProductData["productId"]
                                    ["_id"],
                                quantity,
                                Lat,
                                Long,
                                travellingcost,
                                (total - travellingcost),
                              );
                            }
                          },
                          child: Container(
                            height: 40,
                            width: 250,
                            decoration: BoxDecoration(
                              border: Border.all(color: COLOR.primaryColor),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  child: Image.asset(
                                    'assets/images/shipping.png',
                                    height: 23,
                                    color: COLOR.primaryColor,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: widget.language == "Marathi"
                                        ? Text(
                                            "आता विक्री करा",
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: COLOR.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : Text(
                                            "Sell Now",
                                            style: TextStyle(
                                              fontSize: 19,
                                              color: COLOR.primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child:widget.language=="Marathi" ?  Text(
                      "लवकरच येत आहे",
                    ):Text(
                      "Coming Soon",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
