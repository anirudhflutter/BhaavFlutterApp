import 'package:flutter/material.dart';

class SalesHistoryComponent extends StatefulWidget {
  @override
  _SalesHistoryComponentState createState() => _SalesHistoryComponentState();
}

class _SalesHistoryComponentState extends State<SalesHistoryComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 10, right: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black54, width: 0.7),
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400].withOpacity(0.2),
                  blurRadius: 1.0,
                  spreadRadius: 1.0,
                  offset: Offset(4.0, 5.0))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("ORD-0012"),
                  Text("16-OCT-2020"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    Text(
                      "Goods",
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0, right: 5),
                      child: Text(
                        ":",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      "Onion",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5),
                          child: Text(
                            ":",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Text(
                          "Shipped",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Profit",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 5),
                          child: Text(
                            ":",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Text(
                          "1500",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
