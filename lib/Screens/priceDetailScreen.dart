import 'package:bhaav/constant/constants.dart';
import 'package:bhaav/constant/langString.dart';
import 'package:fcharts/fcharts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceDetailScreen extends StatefulWidget {
  PriceDetailScreen({Key key}) : super(key: key);

  @override
  _PriceDetailScreenState createState() => _PriceDetailScreenState();
}

class _PriceDetailScreenState extends State<PriceDetailScreen> {
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
                      padding: const EdgeInsets.only(left: 20.0, top: 12),
                      child: Image.asset(
                        'assets/images/onion.jpg',
                        height: 110,
                        width: 110,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 35.0),
                      child: Text(
                        'Onion',
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
                      labelText: "Mandi Name",
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
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                  child: Text(
                    "This Month's Price",
                    style: TextStyle(
                        fontSize: 15,
                        color: COLOR.primaryColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Quick'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 110,
                        height: 110,
                        margin: EdgeInsets.only(right: 5, left: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.grey[300], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(4.0, 5.0))
                            ]),
                      ),
                      Container(
                        width: 110,
                        height: 110,
                        margin: EdgeInsets.only(right: 5, left: 5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.grey[300], width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  offset: Offset(4.0, 5.0))
                            ]),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                  child: Text(
                    "This Month's Graph",
                    style: TextStyle(
                        fontSize: 15,
                        color: COLOR.primaryColor,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Quick'),
                  ),
                ),
              ]),
        ));
  }
}
