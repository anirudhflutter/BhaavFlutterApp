import 'package:bhaav/constant/constants.dart';
import 'package:bhaav/constant/langString.dart';
import 'package:bhaav/screen/priceScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

double _value = 10;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 150,
              color: COLOR.primaryColor.withOpacity(0.8),
              child: Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/images/farmer.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text(
                    'Farmer Name',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontFamily: 'Quick',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              onTap: () {
                print("Track Sells");
              },
              title: Text(
                'Track Sells',
                style: TextStyle(fontFamily: 'Quick', fontWeight: FontWeight.w500, fontSize: 20),
              ),
              leading: Image.asset('assets/images/shipping.png'),
            ),
            Container(
              height: 1,
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                print("Sell History");
              },
              title: Text(
                'Sell History',
                style: TextStyle(fontFamily: 'Quick', fontWeight: FontWeight.w500, fontSize: 20),
              ),
              leading: Image.asset('assets/images/history.png'),
            ),
            Container(
              height: 1,
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                print("Help Question");
              },
              title: Text(
                'Support',
                style: TextStyle(fontFamily: 'Quick', fontWeight: FontWeight.w500, fontSize: 20),
              ),
              leading: Image.asset('assets/images/help_ques.png'),
            ),
            Container(
              height: 1,
              color: Colors.black,
            ),
            ListTile(
              onTap: () {
                print("Logout");
              },
              title: Text(
                'Logout',
                style: TextStyle(fontFamily: 'Quick', fontWeight: FontWeight.w500, fontSize: 20),
              ),
              leading: Image.asset('assets/images/logout.png'),
            ),
            Container(
              height: 1,
              color: Colors.black,
            ),
          ],
        ),
      ),
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
          BaseLang.getLogin(),
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
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.red[700],
              inactiveTrackColor: Colors.red[100],
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 4.0,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
              thumbColor: Colors.redAccent,
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
              tickMarkShape: RoundSliderTickMarkShape(),
              activeTickMarkColor: Colors.red[700],
              inactiveTickMarkColor: Colors.red[100],
              valueIndicatorShape: PaddleSliderValueIndicatorShape(),
              valueIndicatorColor: Colors.redAccent,
              valueIndicatorTextStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            child: Slider(
              value: _value,
              min: 0,
              max: 100,
              divisions: 10,
              label: '$_value' + 'm',
              onChanged: (value) {
                setState(
                  () {
                    _value = value;
                  },
                );
              },
            ),
          ),
          TextField(
            keyboardType: TextInputType.text,
            enabled: false,
            decoration: InputDecoration(
              isDense: true,
              labelText: BaseLang.getLocation(),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    enabled: true,
                    decoration: InputDecoration(
                      isDense: true,
                      labelText: BaseLang.getTypeToSearch(),
                      labelStyle: TextStyle(fontFamily: "Quick", color: Colors.black45),
                      contentPadding: EdgeInsets.all(12.0),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        borderSide: BorderSide(color: Color(0xCCF07544)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        borderSide: BorderSide(color: Color(0xCCF07544)),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  child: Image.asset('assets/images/search.png'),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: InkWell(
                        onTap: () {
                          goToNextScreen(PriceScreen());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.network('https://upload.wikimedia.org/wikipedia/commons/2/25/Onion_on_White.JPG'),
                              ),

                              Column(
                                children: [
                                  Text(
                                    'Title',
                                    style: TextStyle(fontFamily: 'Quick', fontSize: 22),
                                  ),
                                  Container(height: 2, width: 100, color: Colors.black12),
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Yesterday',
                                          ),
                                          Text(
                                            '23₹/Kg',
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
                                          Text(
                                            'Today',
                                          ),
                                          Text(
                                            '28₹/Kg',
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Image.asset('assets/images/arrow_down.png'), //TODO show up-down key
                            ],
                          ),
                        ),
                      ),
                    );
                  }))
        ],
      ),
    );
  }

  void goToNextScreen(screen) {
    //if from SplashScreen go to LogIn Screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }
}
