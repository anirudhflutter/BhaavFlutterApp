import 'package:flutter/material.dart';

class ProductComponent extends StatefulWidget {
  Map GetAllProductsData ;
  String Image;
  ProductComponent({this.GetAllProductsData,this.Image});
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
                  height: 90,
                  child: Image.network("${widget.Image}",
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                            child: Text(
                              'Yesterday',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 3.0),
                            child: Text(
                              "${widget.GetAllProductsData["yesterDayHigh"]}"+'₹/Kg',
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
                            child: Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 1.0, left: 3),
                            child: Text(
                              "${widget.GetAllProductsData["highestPrice"]}"+'₹/Kg',
                              style: TextStyle(
                                  fontFamily: 'Quick',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
              widget.GetAllProductsData["highestPrice"] >
                  widget.GetAllProductsData["yesterDayHigh"] ? Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Image.asset('assets/images/arrow_up.png'),
              ):Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Image.asset('assets/images/arrow_down.png'),
              ),
              //TODO show up-down key
            ],
          ),
        ),
      ),
    );
  }
}
