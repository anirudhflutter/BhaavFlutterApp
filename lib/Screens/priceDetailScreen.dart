import 'dart:io';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/foundation.dart';
import 'package:bhaav/Common/Services.dart';
import 'package:bhaav/Common/constants.dart';
import 'package:bhaav/Common/langString.dart';
import 'package:bhaav/Screens/calculateIncomeScreen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../MlDataGraphChart.dart';

class PriceDetailScreen extends StatefulWidget {
  Map individualProductData;
  String language="";

  PriceDetailScreen({this.individualProductData,this.language});

  @override
  _PriceDetailScreenState createState() => _PriceDetailScreenState();
}

class _PriceDetailScreenState extends State<PriceDetailScreen> {
  String selectedDate;

  List GetData = [];

  @override
  void initState() {
    getMlData(
        widget.individualProductData["mandiId"]["MandiName"],
        widget.individualProductData["productId"]["productName"]
    );
    super.initState();
  }

  bool found = false;

  getMlData(String mandiname, String cropName) async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getMlData(mandiname).then((data) async {
          if (data.length > 0) {
            print(data.length);
            for (int i = 0; i < data.length; i++) {
              print("cropName");
              print(cropName);
              print("data cropname");
              print(data[i]["CropName"]);
              if (data[i]["CropName"].toString().toLowerCase() == cropName.toLowerCase()) {
                found = true;
                GetData.add(data[i]["Data"]);
              }
            }
            print("GetData");
            print(GetData);
            print("found");
            print(found);
            if (found == true) {
              GetDataIndexWise();
            }
            setState(() {
              found = false;
            });
          } else {
            // showMsg(data["Message"]);
          }
        }, onError: (e) {
          // showMsg("Try Again.");
        });
      } else {
        // showMsg("No Internet Connection.");
      }
    } on SocketException catch (_) {
      // showMsg("No Internet Connection.");
    }
  }

  List<FarmersMlDataGraph> data1 = [];
  List<FarmersMlDataGraph> data2 = [];

  DataForMlGraph() {
    print(GetData[0].length);
    print(GetData);
    for (int i = 0; i < GetData[0].length; i++) {
      data1.add(
        FarmersMlDataGraph(
          Date: GetData[0][i]["Date"].toString(),
          LowerPrice: GetData[0][i]["Lower Modal Price"].toString(),
          barColor: charts.ColorUtil.fromDartColor(Colors.redAccent),
        ),
      );
      data2.add(
        FarmersMlDataGraph(
          Date: GetData[0][i]["Date"].toString(),
          UpperPrice: GetData[0][i]["Upper Model Price"].toString(),
          barColor: charts.ColorUtil.fromDartColor(Colors.green),
        ),
      );
      i+=5;
    }
  }

  List<DataRow> GetDataCopy = [];
  double lowerprice, upperprice;
  String date = "";
  List allDates = [];

  Widget GetDataIndexWise() {
    for (int i = 0; i < GetData[0].length; i++) {
      lowerprice =
          double.parse(GetData[0][i]["Lower Modal Price"]).roundToDouble();
      upperprice =
          double.parse(GetData[0][i]["Upper Model Price"]).roundToDouble();
      date = GetData[0][i]["Date"].toString().split("-")[2] +
          "-" +
          GetData[0][i]["Date"].toString().split("-")[1] +
          "-" +
          GetData[0][i]["Date"].toString().split("-")[0];
      allDates.add(date);
      DataForMlGraph();
      GetDataCopy.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(
                date,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            DataCell(
              Text(
                "${lowerprice}" + " Rs",
              ),
            ),
            DataCell(
              Text(
                "${upperprice}" + " Rs",
              ),
            ),
          ],
        ),
      );
      print("GetDataCopy");
      print(GetDataCopy);
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
          title: widget.language=="Marathi" ? Text(
            "किंमत तपशील",
            style: TextStyle(
              fontFamily: 'Quick',
              color: Colors.white,
            ),
          ):Text(
            BaseLang.getPriceDetail(),
            style: TextStyle(
              fontFamily: 'Quick',
              color: Colors.white,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        "http://13.234.119.95/" +
                        "${widget.individualProductData["productId"]["productImage"]}",
                        height: 150,
                        width: 150,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: widget.language=="Marathi" ? Text(
                        "${widget.individualProductData["productId"]["productMarathiName"]}",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Quick',
                            fontWeight: FontWeight.bold),
                      ):Text(
                        "${widget.individualProductData["productId"]["productName"]}",
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Quick',
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SIZE_HEIGHT_LOW,
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, right: 15),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Enter Mandi Name",
                      isDense: true,
                      labelText: widget.language=="Marathi"?
                      "${widget.individualProductData["mandiId"]["MandiMarathiName"]}":
                      "${widget.individualProductData["mandiId"]["MandiName"]}",
                      //BaseLang.getFullName(),
                      labelStyle: TextStyle(
                          fontFamily: "Quick", color: COLOR.primaryColor),
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
                GestureDetector(
                  onTap: () {
                    showMonthPicker(
                      context: context,
                      firstDate: DateTime(2010),
                      lastDate: DateTime(2050),
                      initialDate: DateTime.now(),
                      locale: Locale("en"),
                    ).then((date) {
                      if (date != null) {
                        setState(() {
                          selectedDate = date.month.toString();
                        });
                        // getPrrice(selectedDate);
                      }
                    });
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                    child: Row(
                      children: [
                        widget.language=="Marathi" ? Text(
                          "किंमत (मागील / भविष्य)",
                          style: TextStyle(
                              fontSize: 15,
                              color: COLOR.primaryColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Quick'),
                        ):Text(
                          "कPricing (Past/Future)",
                          style: TextStyle(
                              fontSize: 15,
                              color: COLOR.primaryColor,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'Quick'),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: COLOR.primaryColor,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(top: 20.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       Container(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Text(
                //               "Lowest",
                //               style: TextStyle(
                //                 color: Colors.red,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: 18,
                //               ),
                //             ),
                //             Text(
                //                 "${widget.individualProductData["productId"]["yesterDayPrice"]}",
                //               style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: 16,
                //               ),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.only(top: 5.0),
                //               child: Text(
                //                 "15-Oct-2020",
                //                 style: TextStyle(
                //                   color: Colors.grey,
                //                   fontSize: 14,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //         width: 110,
                //         height: 110,
                //         margin: EdgeInsets.only(right: 5, left: 5),
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             border:
                //                 Border.all(color: Colors.grey[300], width: 1),
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(16.0)),
                //             boxShadow: [
                //               BoxShadow(
                //                   color: Colors.grey.withOpacity(0.2),
                //                   blurRadius: 2.0,
                //                   spreadRadius: 2.0,
                //                   offset: Offset(4.0, 5.0))
                //             ]),
                //       ),
                //       Container(
                //         child: Column(
                //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //           children: [
                //             Text(
                //               "Highest",
                //               style: TextStyle(
                //                 color: Colors.green,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: 18,
                //               ),
                //             ),
                //             Text(
                //               "${widget.individualProductData["productId"]["toDayPrice"]}",
                //               style: TextStyle(
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.w600,
                //                 fontSize: 16,
                //               ),
                //             ),
                //             Padding(
                //               padding: const EdgeInsets.only(top: 5.0),
                //               child: Text(
                //                 "17-Oct-2020",
                //                 style: TextStyle(
                //                   color: Colors.grey,
                //                   fontSize: 14,
                //                 ),
                //               ),
                //             ),
                //           ],
                //         ),
                //         width: 110,
                //         height: 110,
                //         margin: EdgeInsets.only(right: 5, left: 5),
                //         decoration: BoxDecoration(
                //             color: Colors.white,
                //             border:
                //                 Border.all(color: Colors.grey[300], width: 1),
                //             borderRadius:
                //                 BorderRadius.all(Radius.circular(16.0)),
                //             boxShadow: [
                //               BoxShadow(
                //                   color: Colors.grey.withOpacity(0.2),
                //                   blurRadius: 2.0,
                //                   spreadRadius: 2.0,
                //                   offset: Offset(4.0, 5.0))
                //             ]),
                //       ),
                //     ],
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GetDataCopy.length == 0
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 50.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : GetDataCopy.length == 0 && found == false
                              ? Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 50.0),
                                    child: widget.language=="Marathi" ?
                                    Text("माहिती आढळली नाही"):Text("No Data Found"),
                                  ),
                                )
                              : DataTable(
                                  columns:  <DataColumn>[
                                    widget.language=="Marathi" ? DataColumn(
                                      label: Text(
                                        'तारीख',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ):DataColumn(
                                      label: Text(
                                        'Date',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ),
                                    widget.language=="Marathi" ?DataColumn(
                                      label: Text(
                                        'सर्वात कमी\nकिंमत\n(क्विंटल)',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ):DataColumn(
                                      label: Text(
                                        'Lowest\nPrice\n(Quintal)',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ),
                                    widget.language=="Marathi" ?DataColumn(
                                      label: Text(
                                        'सर्वाधिक\n किमत\n(क्विंटल)',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ):DataColumn(
                                      label: Text(
                                        'Highest\nPrice\n(Quintal)',
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontSize: 14,
                                          color: Colors.deepOrange,
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: GetDataCopy,
                                ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                  child: widget.language=="Marathi" ?
                   Text(
                    "चार्ट (मागील / भविष्य)",
                    style: TextStyle(
                        fontSize: 15,
                        color: COLOR.primaryColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Quick'),
                  ): Text(
                    "Chart (Past/Future)",
                    style: TextStyle(
                        fontSize: 15,
                        color: COLOR.primaryColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Quick'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, right: 10, left: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 210,
                    child: GetDataCopy.length==0 ? Center(
                      child: widget.language=="Marathi" ?
                      Text("माहिती उपलब्ध नाही"):Text("No Data Available"),
                    ):FarmerChart(
                      data1: data1,
                      data2:data2,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.top + 10,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => calculateIncomeScreen(
                              individualProductData:
                                  widget.individualProductData,
                              language : widget.language
                            ),
                          ),
                        );
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
                                child:  widget.language=="Marathi" ?
                                Text(
                                  "उत्पन्नाची गणना करा",
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: COLOR.primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ):
                                Text(
                                  "Calculate Income",
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
                  ),
                ),
              ]),
        ));
  }
}

class FarmersMlDataGraph {
  final String Date;
  final String LowerPrice;
  final String UpperPrice;
  final charts.Color barColor;

  FarmersMlDataGraph(
      {@required this.Date, @required this.LowerPrice, @required this.barColor,@required this.UpperPrice});
}

