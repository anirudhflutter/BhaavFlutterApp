import 'package:flutter/material.dart';

String API_URL = "https://bhav003.herokuapp.com/";

Map<int, Color> appColorMap1 = {
  50: Color.fromRGBO(56, 31, 113, .1),
  100: Color.fromRGBO(56, 31, 113, .2),
  200: Color.fromRGBO(56, 31, 113, .3),
  300: Color.fromRGBO(56, 31, 113, .4),
  400: Color.fromRGBO(56, 31, 113, .5),
  500: Color.fromRGBO(56, 31, 113, .6),
  600: Color.fromRGBO(56, 31, 113, .7),
  700: Color.fromRGBO(56, 31, 113, .8),
  800: Color.fromRGBO(56, 31, 113, .9),
  900: Color.fromRGBO(56, 31, 113, 1),
};

MaterialColor appPrimaryMaterialColor = MaterialColor(0xFF381F71, appColorMap1);

String mobileNoVerification = "",
    mobileNumber = "",
    Nameonsignup = "",
    Locationonsignup = "",
    Landsizeownedonsignup = "",StateonIdsignup="",DistrictonIdsignup="";
var Latitude=0.0,Longitude=0.0;

const SIZE_HEIGHT_NORMAL = SizedBox(
  height: 25,
  width: 25,
);
const SIZE_HEIGHT_LOWEST = SizedBox(
  height: 8,
  width: 8,
);
const SIZE_HEIGHT_LOW = SizedBox(
  height: 12,
  width: 12,
);

const SIZE_HEIGHT_HIGH = SizedBox(
  height: 30,
  width: 30,
);

class COLOR {
  static const Color primaryColor = Color(0xFFf26f3c);
}

class TextSize {
  static const FONT_LOW = 14.0;
  static const FONT_NORMAL = 16.0;
  static const FONT_HIGH = 20.0;
  static const FONT_HUGE = 24.0;
  static const FONT_GIANT = 28.0;
}
