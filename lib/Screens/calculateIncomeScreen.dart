import 'package:bhaav/Constant/constants.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';

class calculateIncomeScreen extends StatefulWidget {
  @override
  _calculateIncomeScreenState createState() => _calculateIncomeScreenState();
}

class _calculateIncomeScreenState extends State<calculateIncomeScreen>
    with TickerProviderStateMixin {
  String _format = 'yyyy-MMMM-dd';
  DateTime _date = DateTime.now();
  DateTimePickerLocale _locale = DateTimePickerLocale.en_us;
  TextEditingController date = TextEditingController();

  void _showBirthDate() {
    DatePicker.showDatePicker(
      context,
      dateFormat: _format,
      initialDateTime: _date,
      locale: _locale,
      onCancel: () => print('onCancel'),
      onChange: (dateTime, List<int> index) {
        setState(() {
          _date = dateTime;
        });
      },
      onConfirm: (dateTime, List<int> index) {
        setState(() {
          _date = dateTime;
          date.text = _date.toString().split(" ")[0];
        });
        print(_date);
      },
    );
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
          "Calculate Income",
          //  BaseLang.getPrice(),
          style: TextStyle(
            fontFamily: 'Quick',
            color: Colors.white,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 5,
            ),
            Material(
              color: Colors.white,
              child: TabBar(
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: new BubbleTabIndicator(
                    indicatorHeight: 43,
                    indicatorRadius: 6,
                    indicatorColor: COLOR.primaryColor,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  tabs: [
                    Tab(
                      child: Text(
                        "Sell Now",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    Tab(
                        child: Text("Sell Later",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16))),
                  ]),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SIZE_HEIGHT_LOW,
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 17.0, right: 17, top: 15),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Product Name",
                              isDense: true,
                              labelText: "Product",
                              //BaseLang.getFullName(),
                              labelStyle: TextStyle(
                                  fontFamily: "Quick",
                                  color: COLOR.primaryColor),
                              contentPadding: EdgeInsets.all(12.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SIZE_HEIGHT_LOW,
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 17.0, right: 17, top: 15),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Quantity Name",
                              isDense: true,
                              labelText: "Quantity",
                              labelStyle: TextStyle(
                                  fontFamily: "Quick",
                                  color: COLOR.primaryColor),
                              contentPadding: EdgeInsets.all(12.0),
                              suffixIcon: Container(
                                  width: 65,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              width: 1, color: Colors.grey))),
                                  child: Center(
                                    child: Text(
                                      "Kg",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, left: 8),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 30),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle),
                                      height: 14,
                                      width: 14,
                                      // child: Text("data"),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.rectangle),
                                      height: 85,
                                      width: 2,
                                      // child: Text("data"),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: COLOR.primaryColor,
                                          shape: BoxShape.circle),
                                      height: 14,
                                      width: 14,
                                      // child: Text("data"),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 9.0, top: 30),
                                        child: Text(
                                          'My Location,Lorem,ipsum sorem \nStreet No -1,\nAhemedabad,395412',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 9.0, top: 35),
                                        child: Text(
                                          'Sardar Market \nSardar Market near Khand Bazar,\nMaharashtra',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.top + 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 50,
                                    margin: EdgeInsets.only(right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[400], width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "5220",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -8,
                                    left: 12,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Total Cost",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: COLOR.primaryColor,
                                            backgroundColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 50,
                                    margin: EdgeInsets.only(right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[400], width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "10000",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    )),
                                  ),
                                  Positioned(
                                    top: -8,
                                    left: 12,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Profit",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: COLOR.primaryColor,
                                            backgroundColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.top + 40,
                        ),
                        Container(
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
                                    "Sell Now",
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
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SIZE_HEIGHT_LOW,
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 17.0, right: 17, top: 15),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Product Name",
                              isDense: true,
                              labelText: "Product",
                              //BaseLang.getFullName(),
                              labelStyle: TextStyle(
                                  fontFamily: "Quick",
                                  color: COLOR.primaryColor),
                              contentPadding: EdgeInsets.all(12.0),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        SIZE_HEIGHT_LOW,
                        //quantity
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 17.0, right: 17, top: 15),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter Quantity Name",
                              isDense: true,
                              labelText: "Quantity",
                              labelStyle: TextStyle(
                                  fontFamily: "Quick",
                                  color: COLOR.primaryColor),
                              contentPadding: EdgeInsets.all(12.0),
                              suffixIcon: Container(
                                  width: 65,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          left: BorderSide(
                                              width: 1, color: Colors.grey))),
                                  child: Center(
                                    child: Text(
                                      "Kg",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10, top: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 50,
                                    child: TextField(
                                      readOnly: true,
                                      controller: date,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        // hintText: "Select Date",
                                        labelText: "Select Date",
                                        //BaseLang.getFullName(),
                                        labelStyle: TextStyle(
                                            fontFamily: "Quick",
                                            color: COLOR.primaryColor),
                                        contentPadding: EdgeInsets.all(12.0),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide: BorderSide(
                                              color: Colors.grey[400]),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4.0)),
                                          borderSide:
                                              BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      _showBirthDate();
                                    },
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 5, right: 5),
                                        child: Icon(
                                          Icons.date_range,
                                          color: COLOR.primaryColor,
                                          size: 27,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 50,
                                    margin: EdgeInsets.only(right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[400], width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "59/Kg",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    )),
                                  ),
                                  Positioned(
                                    top: -8,
                                    left: 12,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Expected Price",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: COLOR.primaryColor,
                                            backgroundColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20.0, top: 25),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.circle),
                                      height: 14,
                                      width: 14,
                                      // child: Text("data"),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          shape: BoxShape.rectangle),
                                      height: 65,
                                      width: 2,
                                      // child: Text("data"),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          color: COLOR.primaryColor,
                                          shape: BoxShape.circle),
                                      height: 14,
                                      width: 14,
                                      // child: Text("data"),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 20),
                                        child: Text(
                                          'My Location,Lorem,ipsum sorem \nStreet No -1,\nAhemedabad,395412',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 15.0, top: 35),
                                        child: Text(
                                          'Sardar Market \nSardar Market near Khand Bazar,\nMaharashtra',
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.top + 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 50,
                                    margin: EdgeInsets.only(right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[400], width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "5220",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: -8,
                                    left: 12,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Total Cost",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: COLOR.primaryColor,
                                            backgroundColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Stack(
                                overflow: Overflow.visible,
                                children: [
                                  Container(
                                    width: 125,
                                    height: 50,
                                    margin: EdgeInsets.only(right: 5, left: 5),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey[400], width: 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "10000",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    )),
                                  ),
                                  Positioned(
                                    top: -8,
                                    left: 12,
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Profit",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: COLOR.primaryColor,
                                            backgroundColor: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).padding.top + 40,
                        ),
                        Container(
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
                                    "Sell Later",
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
