import 'package:bhaav/constant/constants.dart';
import 'package:bhaav/constant/langString.dart';
import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.only(left: 8.0),
          child: SizedBox(
            height: 60,
            width: 70,
            child: Image.asset('assets/images/ic_bhaav.png'),
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
    );
  }
}
