import 'package:bhaav/Constant/constants.dart';
import 'package:bhaav/Constant/langString.dart';
import 'package:flutter/material.dart';

class SalesHistoryScreen extends StatefulWidget {
  @override
  _SalesHistoryScreenState createState() => _SalesHistoryScreenState();
}

class _SalesHistoryScreenState extends State<SalesHistoryScreen> {
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
          "Sales/History",
          //  BaseLang.getPrice(),
          style: TextStyle(
            fontFamily: 'Quick',
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
