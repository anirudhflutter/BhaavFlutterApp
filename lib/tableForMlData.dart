import 'dart:io';

import 'package:flutter/material.dart';

import 'Common/Services.dart';

class tableForMlData extends StatefulWidget {
  @override
  _tableForMlDataState createState() => _tableForMlDataState();
}

class _tableForMlDataState extends State<tableForMlData> {
  List GetData = [];

  @override
  void initState() {
    getMlData();
    super.initState();
  }

  getMlData() async {
    try {
      //check Internet Connection
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        Services.getMlData().then((data) async {
          if (data.length > 0) {
            print(data.length);
            for (int i = 0; i < data.length; i++) {
              if (data[i]["CropName"] == "BAJRA") {
                GetData.add(data[i]["Data"]);
              }
            }
            GetDataIndexWise();
            setState(() {

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

  List<DataRow> GetDataCopy = [];
  double lowerprice,upperprice;

  Widget GetDataIndexWise() {
    for (int i = 0; i < GetData[0].length; i++) {
      lowerprice = double.parse(GetData[0][i]["Lower Modal Price"]).roundToDouble();
      upperprice = double.parse(GetData[0][i]["Upper Model Price"]).roundToDouble();
      GetDataCopy.add(
        DataRow(
          cells: <DataCell>[
            DataCell(
              Text(
                "${GetData[0][i]["Date"]}",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            DataCell(
              Text(
                "${lowerprice/100}"+" Rs",
              ),
            ),
            DataCell(
              Text(
                "${upperprice/100}"+" Rs",
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Datatable testing"),
        ),
        body: GetData.length == 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            :
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'Date',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Lowest\nPrice',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  'Highest\nPrice',
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
    );
  }
}
