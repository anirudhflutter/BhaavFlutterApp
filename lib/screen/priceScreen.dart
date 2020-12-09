import 'package:bhaav/constant/constants.dart';
import 'package:bhaav/constant/langString.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
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
          BaseLang.getPrice(),
          style: TextStyle(
            fontFamily: 'Quick',
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.network(
                '//TODO add network image',
                cacheHeight: 100,
                cacheWidth: 100,
              ),
              Text(
                'Onion',
                style: TextStyle(fontSize: 22, fontFamily: 'Quick', fontWeight: FontWeight.bold),
              )
            ],
          ),
          SIZE_HEIGHT_LOW,
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: BaseLang.getState(),
                    labelStyle: TextStyle(fontFamily: "Quick", color: COLOR.primaryColor),
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
              ),
              SIZE_HEIGHT_LOWEST,
              Container(
                child: Image.asset('assets/images/ic_down.png'),
              ),
            ],
          ),
          SIZE_HEIGHT_LOW,
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: BaseLang.getDistrict(),
                    labelStyle: TextStyle(fontFamily: "Quick", color: COLOR.primaryColor),
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
              ),
              SIZE_HEIGHT_LOWEST,
              Container(
                child: Image.asset('assets/images/ic_down.png'),
              ),
            ],
          ),
          SIZE_HEIGHT_LOW,
        ],
      ),
    );
  }
}
