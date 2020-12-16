import 'dart:io';

import 'package:bhaav/Common/Services.dart';
import 'package:bhaav/Common/constants.dart';
import 'package:bhaav/Common/langString.dart';
import 'package:bhaav/Components/PriceComponent.dart';
import 'package:bhaav/Components/SalesHistoryComponent.dart';
import 'package:bhaav/Screens/priceDetailScreen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PriceScreen extends StatefulWidget {
  String eachProductId = "";
  int index = 0;
  PriceScreen({this.eachProductId, this.index});
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String _selectState;
  String _selectCity;

  ProgressDialog pr;
  bool isLoading = false;
  List GetDataForStates = [], GetDataForCities = [],StatesDropDown=[],CitiesDropDown=[];

  String selectedDate;
  List getProductDetailsData = [];

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

  getProductDetails() async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var data = {
          "productId": "5fd72eb08de495584afb27c4",
        };
        Services.getProductDetails(data).then((data) async {
          if (data.Data.length > 0) {
            setState(() {
              isLoading = false;
              getProductDetailsData = data.Data;
            });
            print("getProductDetailsData");
            print(getProductDetailsData);
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
  void initState() {
    print("tapped product id");
    print(widget.eachProductId);
    getProductDetails();
    GetStates();
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
              GetDataForStates = data;
            });
            for(int i=0;i<GetDataForStates.length;i++){
              if(!StatesDropDown.contains(GetDataForStates[i]["State"])) {
                StatesDropDown.add(GetDataForStates[i]["State"]);
              }
            }
            print("GetDataForStates");
            print(GetDataForStates);
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

  GetCities(String selectedStateId) async {
    try {
      print("selectedStateId");
      print(selectedStateId);
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        Services.GetCities().then((data) async {
          if (data.length > 0) {
            pr.hide();
            setState(() {
              isLoading = false;
              GetDataForCities = data;
            });
            print("GetDataForCities");
            print(GetDataForCities);
            for (int i = 0; i < GetDataForCities.length; i++) {
              if(selectedStateId==GetDataForCities[i]["State"]["_id"].toString()){
                print("found");
                if(!CitiesDropDown.contains(GetDataForCities[i]["City"])) {
                  CitiesDropDown.add(GetDataForCities[i]["City"]);
                }
              }
            }
            print("CitiesDropDown");
            print(CitiesDropDown);
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
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          BaseLang.getPrice(),
          style: TextStyle(
            fontFamily: 'Quick',
            color: Colors.white,
          ),
        ),
      ),
      body: getProductDetailsData.length == 0
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 12),
                        child: Image.asset(
                          "${getProductDetailsData[widget.index]["productId"]["productImage"]}",
                          height: 110,
                          width: 110,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 35.0),
                        child: Text(
                          "${getProductDetailsData[widget.index]["productId"]["productName"]}",
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Quick',
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 22.0, left: 15, right: 15),
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
                              CitiesDropDown.clear();
                              for(int i=0;i<GetDataForStates.length;i++){
                                if(newvalue==GetDataForStates[i]["State"]){
                                  GetCities(GetDataForStates[i]["_id"]);
                                  print('GetDataForStates[i]["_id"]');
                                  print(GetDataForStates[i]["_id"]);
                                  break;
                                }
                              }
                              setState(() {
                                _selectState = newvalue;
                              });
                            },
                            items: StatesDropDown.map(
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
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 22.0, left: 15, right: 15, bottom: 10),
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
                            hint: Text("Select City"),
                            icon: Icon(
                              Icons.arrow_drop_down,
                              size: 40,
                              color: COLOR.primaryColor,
                            ),
                            isExpanded: true,
                            value: _selectCity,
                            onChanged: (newvalue) {
                              setState(() {
                                _selectCity = newvalue;
                              });
                            },
                            items: CitiesDropDown.map(
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
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width / 3,
                            child: Text("1 Day",
                                style: TextStyle(color: COLOR.primaryColor))),
                        Text("Value",
                            style: TextStyle(color: COLOR.primaryColor)),
                        Text("Changes",
                            style: TextStyle(color: COLOR.primaryColor)),
                        Text("Sell",
                            style: TextStyle(color: COLOR.primaryColor)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 9.0),
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          // scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          separatorBuilder: (BuildContext context, int index) =>
                              Divider(
                                thickness: 1,
                              ),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PriceDetailScreen(
                                      individualProductData:
                                          getProductDetailsData[widget.index],
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    child: Text(
                                      "${getProductDetailsData[widget.index]["mandiId"]["MandiName"]}",
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${getProductDetailsData[widget.index]["productId"]["yesterDayPrice"]}" +
                                            ".00",
                                      ),
                                      Text(
                                        "${getProductDetailsData[widget.index]["productId"]["toDayPrice"]}" +
                                            ".00",
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        "${getProductDetailsData[widget.index]["productId"]["priceChangeIndicator"]}" +
                                            ".00",
                                      ),
                                      Text(
                                        "${getProductDetailsData[widget.index]["productId"]["toDayPrice"]}",
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    "assets/images/shipping.png",
                                    color: COLOR.primaryColor,
                                    height: 30,
                                    width: 30,
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                  )
                ]),
    );
  }
}
/*DataTable(
                    dividerThickness: 1,
                    columnSpacing: 40,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          '1 Day',
                          style: TextStyle(color: COLOR.primaryColor),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Value',
                          style: TextStyle(color: COLOR.primaryColor),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Changes',
                          style: TextStyle(color: COLOR.primaryColor),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Sell',
                          style: TextStyle(color: COLOR.primaryColor),
                        ),
                      ),
                    ],
                    rows: List.generate(
                      userData.length,
                      (index) => DataRow(
                        onSelectChanged: (_) {
                          Navigator.of(context).pushNamed('/PriceDetailScreen');
                        },
                        cells: <DataCell>[
                          DataCell(Text(userData[index]["name"])),
                          DataCell(Text(
                              "${userData[index]["value"][0].toString()}\n${userData[index]["value"][1].toString()}")),
                          DataCell(Text(
                              "${userData[index]["changes"][0].toString()}\n${userData[index]["changes"][1].toString()}")),
                          DataCell(Image.asset(
                            userData[index]["sell"],
                            color: COLOR.primaryColor,
                          )),
                        ],
                      ),
                    )),*/
