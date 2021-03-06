import 'dart:io';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:http/http.dart';
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
  HomeScreen();
  @override
  _HomeScreenState createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  ProgressDialog pr;
  String farmerId = "";
  bool isLoading = false;
  String selectMandi,selectcompany;
  List GetMandiData = [],GetDataFromPythonApi=[];
  List GetAllMandiData = [], GetStatesData = [], GetFarmerProductData = [],
  GetAllMandiDataCopy = [];

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

  loc.LocationData currentLocation;
  String address = "",language="";
  double Lat = 0.0, Long = 0.0;

  GetLocalData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    farmerId = sharedPreferences.getString(FarmerId);
    language = sharedPreferences.getString(languageselection);
    getAllMandi();
  }

  List AllCompanies = [],companiesdata=[],selectedcompany=[];
  getAllCompanies() async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        pr.show();
        setState(() {
          isLoading = true;
        });
        Services.getComapnyList().then((data) async {
          pr.hide();
          if (data[0].length > 0) {
            companiesdata = data[0];
              for(int i=0;i<data[0].length;i++) {
                if(!AllCompanies.contains(data[0][i]["companyName"].toString())) {
                  AllCompanies.add(data[0][i]["companyName"].toString());
                }
              }
            setState(() {
              selectcompany = null;
              isLoading = false;
            });
          } else {
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
        Navigator.pushNamedAndRemoveUntil(
            context, '/LangSelection', (route) => false);
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

  getAllMandi() async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        pr.show();
        setState(() {
          isLoading = true;
        });
        Services.getAllMandi().then((data) async {
          pr.hide();
          if (data.length > 0) {
            GetAllMandiData = data;
            if(language=="Marathi"){
              for(int i=0;i<GetAllMandiData.length;i++) {
                if(!GetAllMandiDataCopy.contains(GetAllMandiData[i]["MandiMarathiName"].toString())) {
                  GetAllMandiDataCopy.add(GetAllMandiData[i]["MandiMarathiName"].toString().replaceAll(".csv",""));
                }
              }
            }
            else {
              for (int i = 0; i < GetAllMandiData.length; i++) {
                if (!GetAllMandiDataCopy.contains(
                    GetAllMandiData[i]["MandiName"].toString())) {
                  GetAllMandiDataCopy.add(
                      GetAllMandiData[i]["MandiName"].toString().replaceAll(".csv", ""));
                }
              }
            }
            setState(() {
              selectMandi = null;
              isLoading = false;
            });
          } else {
          }
          getAllCompanies();
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

  getMandiProducts(String selectedMandiId,String language) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        pr.show();
        setState(() {
          isLoading = true;
        });
        GetMandiData.clear();
        var body = {
          "mandiId" :selectedMandiId,
        };
        Services.getMandiProducts(body).then((data) async {
          pr.hide();
          if (data.length > 0) {
            setState(() {
              isLoading = false;
              GetMandiData = data;
            });
            getUserLocation();
          } else {
            showMsg("");
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

  // getCompanyProducts(String selectedcompanyid,String language) async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       pr.show();
  //       setState(() {
  //         isLoading = true;
  //       });
  //       print(selectMandi);
  //       GetMandiData.clear();
  //       var body = {
  //         "mandiId" :selectedMandiId,
  //       };
  //       Services.getMandiProducts(body).then((data) async {
  //         pr.hide();
  //         if (data.length > 0) {
  //           setState(() {
  //             isLoading = false;
  //             GetMandiData = data;
  //           });
  //           getUserLocation();
  //         } else {
  //           showMsg("");
  //         }
  //       }, onError: (e) {
  //         showMsg("Try Again.");
  //       });
  //     } else {
  //       setState(() {
  //         isLoading = false;
  //       });
  //       pr.hide();
  //       showMsg("No Internet Connection.");
  //     }
  //   } on SocketException catch (_) {
  //     showMsg("No Internet Connection.");
  //   }
  // }

  getMandiFomrPythonApi(String selectedMandi) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // pr.show();
        setState(() {
          isLoading = true;
        });
        Services.getMandiProductsFromPythonApi(selectedMandi).then((data) async {
          if (data.length > 0) {
            setState(() {
              isLoading = false;
              GetDataFromPythonApi = data;
            });
          } else {
            showMsg("");
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

  List filteredData = [];
  getFilteredData(String value){
     for(int i=0;i<GetMandiData.length;i++){
       if(GetMandiData[i]["productId"]["productName"].toString().toLowerCase().contains(value.toLowerCase())){
        filteredData.add(GetMandiData[i]);
        setState(() {
          GetMandiData = filteredData;
        });
       }
     }
  }

  @override
  Widget build(BuildContext context) {
    for(int i=0;i<GetMandiData.length;i++){
      if(GetMandiData[i]["yesterDayHigh"]==null ||
          GetMandiData[i]["productId"]==null){
        GetMandiData.remove(GetMandiData[i]);
      }
    }
    print(GetMandiData);
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
                      height: 72,
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
                    child: language=="Marathi" ?
                    Text(
                      "शोधण्यासाठी टाइप करा",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Quick',
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ):Text(
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
                print("Track Sales");
              },
              title: language=="Marathi" ?
              Text(
                'ट्रॅक विक्री',
                style: TextStyle(
                    fontFamily: 'Quick',
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ):Text(
                'Track Sales',
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
                Navigator.of(context).pushReplacementNamed('/SalesHistoryScreen');
              },
              title: language=="Marathi" ? Text(
                'इतिहास विक्री करा',
                style: TextStyle(
                    fontFamily: 'Quick',
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ):
              Text(
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
              title: language=="Marathi" ?
              Text(
                'आधार',
                style: TextStyle(
                    fontFamily: 'Quick',
                    fontWeight: FontWeight.w500,
                    fontSize: 19),
              ):Text(
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
                title: language=="Marathi" ?
                Text(
                  'बाहेर पडणे',
                  style: TextStyle(
                      fontFamily: 'Quick',
                      fontWeight: FontWeight.w500,
                      fontSize: 19),
                ):Text(
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
      body:
        DefaultTabController(
          length: 2,
          child: Column(
            children: [
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
                      language == "Marathi"
                          ? Tab(
                        child: Text(
                          "मंडई पिके",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      )
                          : Tab(
                        child: Text(
                          "Mandi Crops",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      language == "Marathi"
                          ? Tab(
                          child: Text("कंपनी पिके",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16)))
                          : Tab(
                          child: Text("Company Crops",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16))),
                    ]),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(top: 15, left: 5),
                          //   child: Text(
                          //     "Area to be searched",
                          //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          //   ),
                          // ),
                          // SliderTheme(
                          //   data: SliderTheme.of(context).copyWith(
                          //     activeTrackColor: Colors.red[700],
                          //     inactiveTrackColor: Colors.red[100],
                          //     trackShape: RoundedRectSliderTrackShape(),
                          //     trackHeight: 4.0,
                          //     thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                          //     thumbColor: Colors.redAccent,
                          //     overlayColor: Colors.red.withAlpha(32),
                          //     overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
                          //     tickMarkShape: RoundSliderTickMarkShape(),
                          //     activeTickMarkColor: Colors.red[700],
                          //     inactiveTickMarkColor: Colors.red[100],
                          //     valueIndicatorShape: PaddleSliderValueIndicatorShape(),
                          //     valueIndicatorColor: Colors.redAccent,
                          //     valueIndicatorTextStyle: TextStyle(
                          //       color: Colors.white,
                          //     ),
                          //   ),
                          //   child: Slider(
                          //     value: _value,
                          //     min: 0,
                          //     max: 30,
                          //     divisions: 10,
                          //     label: '$_value' + 'km',
                          //     onChangeEnd: (value){
                          //       dropDownMandiData.clear();
                          //       GetMandiData.clear();
                          //       print("_value");
                          //       print(_value);
                          //       getNearMandi();
                          //     },
                          //     onChanged: (value) {
                          //       print(value.runtimeType);
                          //       setState(
                          //         () {
                          //           _value = value;
                          //         },
                          //       );
                          //     },
                          //   ),
                          // ),
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
                            padding: const EdgeInsets.only(top: 5.0, left: 6, right: 5),
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
                                    hint: language=="Marathi" ?
                                    Text("मंडी निवडा") : Text("Select Mandi"),
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 40,
                                      color: COLOR.primaryColor,
                                    ),
                                    isExpanded: true,
                                    value: selectMandi,
                                    onChanged: (newvalue) {
                                      String selectedmandiId="";
                                      setState(() {
                                        selectMandi = newvalue;
                                      });
                                      if(language=="Marathi"){
                                        for(int i=0;i<GetAllMandiData.length;i++){
                                          if(GetAllMandiData[i]["MandiMarathiName"]==selectMandi){
                                            print(GetAllMandiData[i]);
                                            selectedmandiId = GetAllMandiData[i]["_id"];
                                            break;
                                          }
                                        }
                                      }
                                      else{
                                        for(int i=0;i<GetAllMandiData.length;i++){
                                          if(GetAllMandiData[i]["MandiName"]==selectMandi){
                                            print(GetAllMandiData[i]);
                                            selectedmandiId = GetAllMandiData[i]["_id"];
                                            break;
                                          }
                                        }
                                      }
                                      getMandiProducts(selectedmandiId,language);
                                    },
                                    items: GetAllMandiDataCopy.map(
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
                          // Container(
                          //   padding: EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(top: 12.0),
                          //     child: Row(
                          //       children: [
                          //         Expanded(
                          //           child: TextField(
                          //             keyboardType: TextInputType.text,
                          //             enabled: true,
                          //             decoration: InputDecoration(
                          //               isDense: true,
                          //               labelText: BaseLang.getTypeToSearch(),
                          //               labelStyle: TextStyle(
                          //                   fontFamily: "Quick", color: Colors.black45),
                          //               contentPadding: EdgeInsets.all(12.0),
                          //               enabledBorder: OutlineInputBorder(
                          //                 borderRadius:
                          //                     BorderRadius.all(Radius.circular(4.0)),
                          //                 borderSide: BorderSide(color: Color(0xCCF07544)),
                          //               ),
                          //               focusedBorder: OutlineInputBorder(
                          //                 borderRadius:
                          //                     BorderRadius.all(Radius.circular(4.0)),
                          //                 borderSide: BorderSide(color: Color(0xCCF07544)),
                          //               ),
                          //             ),
                          //             onChanged: (value) {
                          //               print(value);
                          //               getFilteredData(value);
                          //             },
                          //           ),
                          //         ),
                          //         Padding(
                          //           padding: const EdgeInsets.only(left: 5),
                          //           child: InkWell(
                          //             child: Image.asset(
                          //               'assets/images/search.png',
                          //               width: 30,
                          //               height: 25,
                          //             ),
                          //           ),
                          //         )
                          //       ],
                          //     ),
                          //   ),
                          // ),
                           selectMandi==null && GetAllMandiData.length>0
                              ? Padding(
                            padding: const EdgeInsets.only(top: 120.0),
                            child: Center(
                              child: language=="Marathi" ? Text(
                                "कृपया मंडी निवडा",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ):Text(
                                "Please select Mandi",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )
                              :  GetMandiData.length==0
                              ? Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: Center(
                              child: language=="Marathi" ? Text(
                                "माहिती आढळली नाही",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ):Text(
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
                                                  builder: (context) =>
                                                      PriceScreen(
                                                          GetMandiData: GetMandiData[index],
                                                          language: language
                                                      ),
                                                ),
                                              );
                                          },
                                          child: ProductComponent(
                                            GetAllProductsData: GetMandiData[index],
                                            language:language
                                            // ["productId"],
                                          ),
                                        );
                                      }),
                                ))
                        ],
                      ),
                    ),
                    Center(
                      child: language=="Marathi" ?
                      Text("लवकरच येत आहे"):Text("Coming Soon!!!"),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 15.0, right: 15),
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       SIZE_HEIGHT_LOW,
                    //       Padding(
                    //         padding: const EdgeInsets.only(top: 5.0, left: 6, right: 5),
                    //         child: Container(
                    //           decoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(8.0),
                    //             border: Border.all(
                    //               color: COLOR.primaryColor,
                    //               style: BorderStyle.solid,
                    //               width: 0.80,
                    //             ),
                    //           ),
                    //           child: DropdownButtonHideUnderline(
                    //             child: Padding(
                    //               padding: const EdgeInsets.only(left: 2.0),
                    //               child: DropdownButton<dynamic>(
                    //                 dropdownColor: Colors.white,
                    //                 hint: language=="Marathi" ?
                    //                 Text("कंपनी निवडा") : Text("Select Company"),
                    //                 icon: Icon(
                    //                   Icons.arrow_drop_down,
                    //                   size: 40,
                    //                   color: COLOR.primaryColor,
                    //                 ),
                    //                 isExpanded: true,
                    //                 value: selectcompany,
                    //                 onChanged: (newvalue) {
                    //                   print("tapped");
                    //                   String selectedcompanyid="";
                    //                   setState(() {
                    //                     selectcompany = newvalue;
                    //                   });
                    //                     for(int i=0;i<companiesdata.length;i++){
                    //                       if(companiesdata[i]["companyName"]==selectcompany){
                    //                         selectedcompany.add(companiesdata[i]);
                    //                         break;
                    //                       }
                    //                     }
                    //                   print("selectedcompanyid");
                    //                   print(selectedcompanyid);
                    //                   // getCompanyProducts(selectedcompanyid,widget.language);
                    //                 },
                    //                 items: GetAllMandiDataCopy.map(
                    //                   (Location) {
                    //                     return DropdownMenuItem(
                    //                       child: Text(Location),
                    //                       value: Location,
                    //                     );
                    //                   },
                    //                 ).toList(),
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //        selectedcompany==null && companiesdata.length>0
                    //           ? Padding(
                    //         padding: const EdgeInsets.only(top: 120.0),
                    //         child: Center(
                    //           child: language=="Marathi" ? Text(
                    //             "कृपया कंपनी निवडा",
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 15,
                    //             ),
                    //           ):Text(
                    //             "Please select Company",
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //           :  companiesdata.length==0
                    //           ? Padding(
                    //         padding: const EdgeInsets.only(top: 100.0),
                    //         child: Center(
                    //           child: language=="Marathi" ? Text(
                    //             "कृपया कंपनी निवडा",
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 15,
                    //             ),
                    //           ):Text(
                    //             "Please select Company",
                    //             style: TextStyle(
                    //               fontWeight: FontWeight.bold,
                    //               fontSize: 15,
                    //             ),
                    //           ),
                    //         ),
                    //       )
                    //           : Expanded(
                    //               child: Padding(
                    //               padding: const EdgeInsets.only(top: 15.0),
                    //               child: ListView.builder(
                    //                   itemCount: selectedcompany.length,
                    //                   itemBuilder: (context, index) {
                    //                     return InkWell(
                    //                       onTap: () {
                    //                         Navigator.push(
                    //                           context,
                    //                           MaterialPageRoute(
                    //                             builder: (context) => PriceScreen(
                    //                               GetMandiData: GetMandiData[index],
                    //                               language:language
                    //                             ),
                    //                           ),
                    //                         );
                    //                       },
                    //                       child: ProductComponent(
                    //                         GetAllProductsData: selectedcompany[index],
                    //                         language:language
                    //                         // ["productId"],
                    //                       ),
                    //                     );
                    //                   }),
                    //             ))
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
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
