import 'dart:io';

import 'package:bhaav/Common/Services.dart';
import 'package:bhaav/Common/constants.dart';
import 'package:bhaav/Common/langString.dart';
import 'package:bhaav/Components/ProductComponent.dart';
import 'package:bhaav/Screens/priceDetailScreen.dart';
import 'package:bhaav/Screens/priceScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:location/location.dart' as loc;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

double _value = 0;
double areaToBeSearched = 0;

class _HomeScreenState extends State<HomeScreen> {
  ProgressDialog pr;
  String farmerId = "";
  bool isLoading = false;
  String selectMandi;
  List GetMandiData = [];
  List GetAllMandiData = [], GetStatesData = [], GetFarmerProductData = [];
  List dropDownMandiData = [];

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
            color: Colors.red, fontSize: 17.0, fontWeight: FontWeight.w600));
    // TODO: implement initState
    super.initState();
  }

  loc.LocationData currentLocation;
  String address = "";
  double Lat = 0.0, Long = 0.0;

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
    print(
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first.subAdminArea},${first.addressLine}, ${first.featureName},${first.thoroughfare}, ${first.subThoroughfare}');
    return first;
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
  List copyofMandiData = [];

  getNearMandi(double areaToBeSearched) async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        pr.show();
        setState(() {
          isLoading = true;
        });
        print("request sent to allmandidata");
        print(areaToBeSearched);
        print(Lat);
        print(Long);
        var data = {
          "uptoKm": areaToBeSearched,
          "userLat": Lat,
          "userLong": Long,
        };
        Services.getNearMandi(data).then((data) async {
          pr.hide();
          if (data.length > 0) {
            // Fluttertoast.showToast(
            //     msg: data["Message"],
            //     backgroundColor: Colors.red,
            //     gravity: ToastGravity.TOP,
            //     toastLength: Toast.LENGTH_SHORT);
            GetAllMandiData = data;
            copyofMandiData = GetAllMandiData;
            for (int i = 0; i < GetAllMandiData.length; i++) {
              if(!dropDownMandiData.contains(GetAllMandiData[i]["mandiData"]["MandiName"])) {
                dropDownMandiData
                    .add(
                    GetAllMandiData[i]["mandiData"]["MandiName"].toString());
              }
            }
            print("dropDownMandiData");
            print(dropDownMandiData);
            setState(() {
              isLoading = false;
            });
          } else {
            // showMsg(data["Message"]);
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

  getMandiProducts(String selectedMandi) async {
    try {
      String selectedMandiId = "";
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        pr.show();
        setState(() {
          isLoading = true;
        });
        for (int i = 0; i < copyofMandiData.length; i++) {
          if (selectedMandi == copyofMandiData[i]["mandiData"]["MandiName"]) {
            selectedMandiId = copyofMandiData[i]["mandiData"]["_id"];
            break;
          }
        }
        print("selectedMandi");
        print(selectedMandi);
        print("selectedMandiId");
        print(selectedMandiId);
        var data = {
          "mandiId": selectedMandiId, // pass selectedmandiId
        };
        GetMandiData.clear();
        Services.getMandiProducts(data).then((data) async {
          pr.hide();
          if (data.length > 0) {
            // Fluttertoast.showToast(
            //     msg: "${data.Message}",
            //     backgroundColor: Colors.red,
            //     gravity: ToastGravity.TOP,
            //     toastLength: Toast.LENGTH_SHORT);
            setState(() {
              isLoading = false;
              GetMandiData = data;
            });
            getUserLocation();
          } else {
            // showMsg("${data.Message}");
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
                max: 30,
                divisions: 10,
                label: '$_value' + 'km',
                onChangeEnd: (value){
                  dropDownMandiData.clear();
                  GetMandiData.clear();
                  print("_value");
                  print(_value);
                  getNearMandi(_value);
                },
                onChanged: (value) {
                  print(value.runtimeType);
                  setState(
                    () {
                      _value = value;
                    },
                  );
                },
              ),
            ),
            SIZE_HEIGHT_LOW,
            // Center(
            //   child: RaisedButton(
            //       child: Text(
            //         "Search",
            //         style: TextStyle(
            //           fontFamily: 'Quick',
            //           color: Colors.white,
            //         ),
            //       ),
            //       color: COLOR.primaryColor,
            //       onPressed: () {
            //
            //       }),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 6, right: 41),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: COLOR.primaryColor,
                    style: BorderStyle.solid,
                    width: 0.80,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: DropdownButton<dynamic>(
                      dropdownColor: Colors.white,
                      hint: Text("Select Mandi"),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 40,
                        color: COLOR.primaryColor,
                      ),
                      isExpanded: true,
                      value: selectMandi,
                      onChanged: (newvalue) {
                        setState(() {
                          selectMandi = newvalue;
                        });
                        getMandiProducts(selectMandi);
                      },
                      items: dropDownMandiData.map(
                        (Location) {
                          return DropdownMenuItem(
                            child: Text(Location),
                            value: Location,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 6.0, right: 6),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       isDense: true,
            //       labelText: "My Location",
            //       labelStyle:
            //           TextStyle(fontFamily: "Quick", color: COLOR.primaryColor),
            //       contentPadding: EdgeInsets.all(12.0),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(4.0)),
            //         borderSide: BorderSide(color: Colors.grey),
            //       ),
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(4.0)),
            //         borderSide: BorderSide(color: Colors.grey),
            //       ),
            //     ),
            //     controller: edtLocationController,
            //   ),
            // ),
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
            GetMandiData.length==0
                ? Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Center(
                      child: Text(
                        "No Data Found",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: ListView.builder(
                        itemCount: GetMandiData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PriceScreen(
                                    eachProductId: GetMandiData[index]["_id"],
                                    index: index,
                                  ),
                                ),
                              );
                            },
                            child: ProductComponent(
                              GetAllProductsData: GetMandiData[index]
                                  ["productId"],
                            ),
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
