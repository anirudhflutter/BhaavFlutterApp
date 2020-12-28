import 'dart:io';

import 'package:bhaav/Common/Services.dart';
import 'package:bhaav/Common/constants.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;
import 'package:bhaav/Common/langString.dart';
import 'package:bhaav/firebaseauth/firebase/auth/phone_auth/verify.dart';
import 'package:bhaav/firebaseauth/providers/phone_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kGoogleApiKey = "AIzaSyCm9L8-lLCSpRYME1D4lfMb4CS-oX1U6eQ";
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class SignupScreen extends StatefulWidget {
  SignupScreen();
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  ProgressDialog pr;
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
  var Lat=0.0, Long=0.0;
  String _selectState,SelectedState="";
  String _selectCity,SelectedCity="",language="";
  List<String> GetStatesData = [], GetCityData = [],GetStatesIdData=[],GetCityIdData=[];

  GetLocalData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    language = sharedPreferences.getString(languageselection);
  }

  @override
  void initState() {
    GetStates();
    GetLocalData();
    // GetCities();
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
    String stateid="",cityid="";
    for(int i=0;i<GetStatesData.length;i++){
      if(SelectedState==GetStatesData[i]){
        stateid = GetStatesIdData[i];
        break;
      }
    }
    for(int i=0;i<GetCityData.length;i++){
      if(SelectedCity==GetCityData[i]){
        cityid = GetCityIdData[i];
        break;
      }
    }

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(mobilenumber, edtMobileController.text.toString());
    sharedPreferences.setString(Nameonsignup, edtNameController.text.toString());
    sharedPreferences.setString(Locationonsignup, edtLocationController.text.toString());
    sharedPreferences.setDouble(Latitude.toString(), Lat);
    sharedPreferences.setDouble(Longitude.toString(), Long);
    sharedPreferences.setString(
        Landsizeownedonsignup, edtLandSizeOwnedController.text.toString());
    sharedPreferences.setString(StateonIdsignup, stateid);
    sharedPreferences.setString(DistrictonIdsignup, cityid);

    print("data found");
    print(mobilenumber);
    print(Nameonsignup);
    print(Landsizeownedonsignup);
    print(StateonIdsignup);

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
                  PhoneAuthVerify(register: false)));
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
          }
          if (userfound) {
            showMsg("This mobile number is already registered please login");
          } else {
            print("user not found");
            print(edtMobileController.text);
            print(edtNameController.text);
            print(edtLocationController.text);
            print(edtLandSizeOwnedController.text);

            startPhoneAuth();
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

  loc.LocationData currentLocation;
  String address = "";

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
        ' ${first.locality}, ${first.adminArea},${first.subLocality}, ${first
            .subAdminArea},${first.addressLine}, ${first.featureName},${first
            .thoroughfare}, ${first.subThoroughfare}');
    setState(() {
      edtLocationController.text = first.addressLine;
    });
    return first;
  }

  final homeScaffoldKey = GlobalKey<ScaffoldState>();

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  searchPickLocation() async {
    try {
      print("Current Location");
      Prediction p = await PlacesAutocomplete.show(
        context: context,
        hint: language=="Marathi" ? "आपले स्थान शोधा" : "Search your location",
        apiKey: kGoogleApiKey,
        onError: onError,
        mode: Mode.overlay,
        language: "en",
        components: [
          Component(Component.country, "in"),
        ],
        location: currentLocation == null
            ? null
            : Location(currentLocation.latitude, currentLocation.longitude),
      );
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);
      setState(() {
        edtLocationController.text = p.description;
        Lat = detail.result.geometry.location.lat;
        Long = detail.result.geometry.location.lng;
      });
      Navigator.of(context).pop(true);
    }
    catch (e) {
      return;
    }

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



  GetStates() async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.GetStates().then((data) async {
          if (data.length > 0) {
            pr.hide();
            setState(() {
              isLoading = false;
            });
            for (int i = 0; i < data.length; i++) {
              GetStatesData.add(data[i]["State"]);
            }
            for (int i = 0; i < data.length; i++) {
              GetStatesIdData.add(data[i]["_id"]);
            }
            print("GetStatesData");
            print(GetStatesData);
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

  // GetCities() async {
  //   try {
  //     //check Internet Connection
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
  //       setState(() {
  //         isLoading = true;
  //       });
  //       Services.GetCities().then((data) async {
  //         if (data.length > 0) {
  //           pr.hide();
  //           setState(() {
  //             isLoading = false;
  //           });
  //           for (int i = 0; i < data.length; i++) {
  //             GetCityData.add(data[i]["City"]);
  //           }
  //           for (int i = 0; i < data.length; i++) {
  //             GetCityIdData.add(data[i]["_id"]);
  //           }
  //           print("GetCityData");
  //           print(GetCityData);
  //         }
  //       }, onError: (e) {
  //         pr.hide();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(20.0)),
                                //this right here
                                child: Container(
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              getUserLocation();
                                              Navigator.of(context).pop(true);
                                            },
                                            child: language=="Marathi" ? Text(
                                              "सध्याचे स्थान मिळवा",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ):Text(
                                              "Get Current Location",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: const Color(0xFF1BC0C5),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 320.0,
                                          child: RaisedButton(
                                            onPressed: () {
                                              searchPickLocation();
                                            },
                                            child: language=="Marathi" ? Text(
                                              "स्थान शोधा",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ):Text(
                                              "Find Location",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            color: const Color(0xFF1BC0C5),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      controller: edtLocationController,
                      decoration: InputDecoration(
                        isDense: true,
                        labelText: edtLocationController.text=="" ? BaseLang.getLocation():edtLocationController.text,
                        labelStyle: TextStyle(
                            fontFamily: "Quick", color: COLOR.primaryColor),
                        contentPadding: EdgeInsets.all(12.0),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(4.0)),
                          borderSide: BorderSide(color: Color(0xFF707070)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(4.0)),
                          borderSide: BorderSide(color: Color(0xFF707070)),
                        ),
                      ),
                      minLines: 2,
                      maxLines: 4,
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
                    width: 90,
                    height: 35,
                    child: TextField(
                      controller: edtLandSizeOwnedController,
                      style: TextStyle(
                        fontFamily: 'Quick',
                        fontSize: TextSize.FONT_HIGH,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                      maxLength: 10,
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
              Padding(
                padding: const EdgeInsets.only(top: 22.0, left: 15, right: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                        color: COLOR.primaryColor,
                        style: BorderStyle.solid,
                        width: 0.80),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5),
                      child: DropdownButton(
                        dropdownColor: Colors.white,
                        hint: Text("Select State"),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          size: 40,
                          color: COLOR.primaryColor,
                        ),
                        isExpanded: true,
                        value: _selectState,
                        onChanged: (newvalue) {
                          SelectedState = newvalue;
                          setState(() {
                            _selectState = newvalue;
                          });
                        },
                        items: GetStatesData.map(
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
              //   padding: const EdgeInsets.only(
              //       top: 22.0, left: 15, right: 15, bottom: 10),
              //   child: Container(
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8.0),
              //       border: Border.all(
              //           color: COLOR.primaryColor,
              //           style: BorderStyle.solid,
              //           width: 0.80),
              //     ),
              //     child: DropdownButtonHideUnderline(
              //       child: Padding(
              //         padding: const EdgeInsets.only(left: 5.0, right: 5),
              //         child: DropdownButton(
              //           dropdownColor: Colors.white,
              //           hint: Text("Select City"),
              //           icon: Icon(
              //             Icons.arrow_drop_down,
              //             size: 40,
              //             color: COLOR.primaryColor,
              //           ),
              //           isExpanded: true,
              //           value: _selectCity,
              //           onChanged: (newvalue) {
              //             SelectedCity = newvalue;
              //             setState(() {
              //               _selectCity = newvalue;
              //             });
              //           },
              //           items: GetCityData.map(
              //                 (Location) {
              //               return DropdownMenuItem(
              //                 child: Text(Location),
              //                 value: Location,
              //               );
              //             },
              //           ).toList(),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              SIZE_HEIGHT_LOW,
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    print(edtMobileController.text);
                    if (edtMobileController.text == "" ||
                        edtMobileController.text.length != 10 ||
                        edtNameController.text == "" ||
                        edtLocationController.text == "" ||
                        edtLandSizeOwnedController.text == "" ||
                        _selectState == "") {
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

  }
