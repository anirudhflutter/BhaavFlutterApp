import 'package:bhaav/Common/constants.dart';
import 'package:bhaav/Common/langString.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PriceDetailScreen extends StatefulWidget {
  PriceDetailScreen({Key key}) : super(key: key);

  @override
  _PriceDetailScreenState createState() => _PriceDetailScreenState();
}

class _PriceDetailScreenState extends State<PriceDetailScreen> {
  String selectedDate;
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
                        Text(
                          "This Month's Price",
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Lowest",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "15.00",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "15-Oct-2020",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Highest",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "20.00",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5.0),
                              child: Text(
                                "17-Oct-2020",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
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
                Padding(
                  padding:
                      const EdgeInsets.only(top: 25.0, right: 10, left: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 210,
                    child: LineChart(
                      LineChartData(
                        lineTouchData: LineTouchData(enabled: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 4),
                              FlSpot(1, 3.5),
                              FlSpot(2, 4.5),
                              FlSpot(3, 1),
                              FlSpot(4, 4),
                              FlSpot(5, 6),
                              FlSpot(6, 6.5),
                              FlSpot(7, 6),
                              FlSpot(8, 4),
                              FlSpot(9, 6),
                              FlSpot(10, 6),
                              FlSpot(11, 7),
                            ],
                            isCurved: true,
                            barWidth: 2,
                            colors: [
                              Colors.green,
                            ],
                            dotData: FlDotData(
                              show: false,
                            ),
                          ),
                        ],
                        titlesData: FlTitlesData(
                          bottomTitles: SideTitles(
                              showTitles: true,
                              getTextStyles: (value) => const TextStyle(
                                  fontSize: 10,
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold),
                              getTitles: (value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return 'Jan';
                                  case 1:
                                    return 'Feb';
                                  case 2:
                                    return 'Mar';
                                  case 3:
                                    return 'Apr';
                                  case 4:
                                    return 'May';
                                  case 5:
                                    return 'Jun';
                                  case 6:
                                    return 'Jul';
                                  case 7:
                                    return 'Aug';
                                  case 8:
                                    return 'Sep';
                                  case 9:
                                    return 'Oct';
                                  case 10:
                                    return 'Nov';
                                  case 11:
                                    return 'Dec';
                                  default:
                                    return '';
                                }
                              }),
                          leftTitles: SideTitles(
                            showTitles: true,
                            getTitles: (value) {
                              return '\$ ${value + 0.5}';
                            },
                          ),
                        ),
                      ),
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
                        Navigator.of(context)
                            .pushNamed('/calculateIncomeScreen');
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
                                child: Text(
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
