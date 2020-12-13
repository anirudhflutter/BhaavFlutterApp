import 'package:bhaav/Common/constants.dart';
import 'package:flutter/material.dart';

class PriceComponent extends StatefulWidget {
  @override
  _PriceComponentState createState() => _PriceComponentState();
}

class _PriceComponentState extends State<PriceComponent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/PriceDetailScreen');
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: MediaQuery.of(context).size.width / 3,
              child: Text("Sardar Market Pvt")),
          Column(
            children: [
              Text("15.0"),
              Text("18.0"),
            ],
          ),
          Column(
            children: [
              Text("+3.00"),
              Text("+25.00%"),
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
  }
}
