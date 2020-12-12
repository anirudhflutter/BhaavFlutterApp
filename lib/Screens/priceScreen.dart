import 'package:bhaav/Components/PriceComponent.dart';
import 'package:bhaav/Components/SalesHistoryComponent.dart';
import 'package:bhaav/constant/constants.dart';
import 'package:bhaav/constant/langString.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  List<String> _locations = ['Maharashtra', 'Gujrat', 'Madhyaprdesh'];
  String _selectState;
  List<String> _city = ['surat', 'Ahemedabad', 'Mumbai'];
  String _selectCity;
  List userData = [
    {
      "id": 1,
      "name": "Sardar Market",
      "value": ["15.0", "18.0"],
      "changes": ["+3.00", "+25.00%"],
      "sell": 'assets/images/shipping.png',
    },
    {
      "id": 2,
      "name": "ramji Market",
      "value": ["10.0", "15.0"],
      "changes": ["+4.00", "+30.00%"],
      "sell": 'assets/images/shipping.png',
    },
    {
      "id": 3,
      "name": "chowta Market",
      "value": ["18.0", "20.0"],
      "changes": ["+5.00", "+20.00%"],
      "sell": 'assets/images/shipping.png',
    },
    {
      "id": 4,
      "name": "Baroda Market",
      "value": ["16.0", "19.0"],
      "changes": ["+1.00", "+26.00%"],
      "sell": 'assets/images/shipping.png',
    },
    {
      "id": 5,
      "name": "Baroda Market",
      "value": ["16.0", "19.0"],
      "changes": ["+1.00", "+26.00%"],
      "sell": 'assets/images/shipping.png',
    },
    {
      "id": 6,
      "name": "Baroda Market",
      "value": ["16.0", "19.0"],
      "changes": ["+1.00", "+26.00%"],
      "sell": 'assets/images/shipping.png',
    },
    {
      "id": 7,
      "name": "Baroda Market",
      "value": ["16.0", "19.0"],
      "changes": ["+1.00", "+26.00%"],
      "sell": 'assets/images/shipping.png',
    },
    {
      "id": 8,
      "name": "Baroda Market",
      "value": ["16.0", "19.0"],
      "changes": ["+1.00", "+26.00%"],
      "sell": 'assets/images/shipping.png',
    },
    {
      "id": 9,
      "name": "Baroda Market",
      "value": ["16.0", "19.0"],
      "changes": ["+1.00", "+26.00%"],
      "sell": 'assets/images/shipping.png',
    }
  ];

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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, top: 12),
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
            Padding(
              padding: const EdgeInsets.only(top: 22.0, left: 15, right: 15),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: COLOR.primaryColor,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      hint: Text("Select State"),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 40,
                        color: COLOR.primaryColor,
                      ),
                      isExpanded: true,
                      value: _selectState,
                      onChanged: (newvalue) {
                        setState(() {
                          _selectState = newvalue;
                        });
                      },
                      items: _locations.map(
                        (Location) {
                          return DropdownMenuItem(
                            child: Text(Location),
                            value: Location,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 22.0, left: 15, right: 15, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                      color: COLOR.primaryColor,
                      style: BorderStyle.solid,
                      width: 0.80),
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5.0, right: 5),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      hint: Text("Select City"),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 40,
                        color: COLOR.primaryColor,
                      ),
                      isExpanded: true,
                      value: _selectCity,
                      onChanged: (newvalue) {
                        setState(() {
                          _selectCity = newvalue;
                        });
                      },
                      items: _city.map(
                        (Location) {
                          return DropdownMenuItem(
                            child: Text(Location),
                            value: Location,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Text("1 Day",
                          style: TextStyle(color: COLOR.primaryColor))),
                  Text("Value", style: TextStyle(color: COLOR.primaryColor)),
                  Text("Changes", style: TextStyle(color: COLOR.primaryColor)),
                  Text("Sell", style: TextStyle(color: COLOR.primaryColor)),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 9.0),
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    // scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                          thickness: 1,
                        ),
                    itemBuilder: (BuildContext context, int index) {
                      return PriceComponent();
                    }),
              ),
            )
          ]),
    );
  }
}
/*DataTable(
                    dividerThickness: 1,
                    columnSpacing: 40,
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text(
                          '1 Day',
                          style: TextStyle(color: COLOR.primaryColor),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Value',
                          style: TextStyle(color: COLOR.primaryColor),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Changes',
                          style: TextStyle(color: COLOR.primaryColor),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          'Sell',
                          style: TextStyle(color: COLOR.primaryColor),
                        ),
                      ),
                    ],
                    rows: List.generate(
                      userData.length,
                      (index) => DataRow(
                        onSelectChanged: (_) {
                          Navigator.of(context).pushNamed('/PriceDetailScreen');
                        },
                        cells: <DataCell>[
                          DataCell(Text(userData[index]["name"])),
                          DataCell(Text(
                              "${userData[index]["value"][0].toString()}\n${userData[index]["value"][1].toString()}")),
                          DataCell(Text(
                              "${userData[index]["changes"][0].toString()}\n${userData[index]["changes"][1].toString()}")),
                          DataCell(Image.asset(
                            userData[index]["sell"],
                            color: COLOR.primaryColor,
                          )),
                        ],
                      ),
                    )),*/
