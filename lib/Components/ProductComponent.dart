import 'dart:io';

import 'package:flutter/material.dart';

class ProductComponent extends StatefulWidget {
  Map GetAllProductsData ;
  String language="";
  ProductComponent({this.GetAllProductsData,this.language});
  @override
  _ProductComponentState createState() => _ProductComponentState();
}

class _ProductComponentState extends State<ProductComponent> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  // width: 90,
                  height: 80,
                    child:
                    widget.GetAllProductsData["productId"]!=null ? Image.network(
                      "http://13.234.119.95/" +
                        "${widget.GetAllProductsData["productId"]["productImage"]}",
                    width: 80,
                      height: 80,
                    ):Container(),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  widget.language=="Marathi" ?
                  Text(
                    "${widget.GetAllProductsData["productId"]["productMarathiName"]}",
                    style: TextStyle(fontFamily: 'Quick', fontSize: 22),
                  ):
                  Text(
                    "${widget.GetAllProductsData["productId"]["productName"]}",
                    style: TextStyle(fontFamily: 'Quick', fontSize: 22),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child:
                        Container(height: 2, width: 100, color: Colors.black12),
                  ),
                  Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: widget.language=="Marathi" ? Text(
                              'काल',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ):Text(
                              'Yesterday',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: widget.language=="Marathi" ? Text(
                              "${widget.GetAllProductsData["yesterDayHigh"]}"+'₹/क्विंटल',
                            ):Text(
                              "${widget.GetAllProductsData["yesterDayHigh"]}"+'₹/Quintal',
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                          height: 40,
                          width: 2,
                          color: Colors.black12,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: widget.language=="Marathi" ? Text(
                              'आज',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ):Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0, left: 3),
                            child: widget.language=="Marathi" ? Text(
                              "${widget.GetAllProductsData["highestPrice"]}"+'₹/क्विंटल',
                              style: TextStyle(
                                  fontFamily: 'Quick',
                                  fontSize: 15,
                                  ),
                            ): Text(
                              "${widget.GetAllProductsData["highestPrice"]}"+'₹/Quintal',
                              style: TextStyle(
                                  fontFamily: 'Quick',
                                  fontSize: 15,
                                 ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              widget.GetAllProductsData["yesterDayHigh"]!=null ? widget.GetAllProductsData["highestPrice"] >
                  widget.GetAllProductsData["yesterDayHigh"] ? Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Image.asset('assets/images/arrow_up.png'),
              ):Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Image.asset('assets/images/arrow_down.png'),
              ):Container(),
              //TODO show up-down key
            ],
          ),
        ),
      ),
    );
  }
}
