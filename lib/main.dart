import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:http/http.dart' as http;
import 'package:weather/model/condition.dart';
import 'package:weather/model/current.dart';

import 'package:weather/model/global.dart';
import 'package:weather/model/location.dart';
import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'A244FF46BB3FEAE0FDA76F3E36987E7A';
main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();

  Home();
}

class _HomeState extends State<Home> {
  bool clicked = false;
  bool items = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String city = "";
static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    
   
   
  childDirected: false,
 
    keywords: <String>['games'],
  );

BannerAd _bannerAd;
InterstitialAd _interstitialAd;

BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: "ca-app-pub-1835500137160582/1298304450",
        
      //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("BannerAd $event");
        });
  }

  InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: 'ca-app-pub-1835500137160582/2419814436',
      //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          print("IntersttialAd $event");
        });
  }







final appId="ca-app-pub-1835500137160582~7183371746";

  @override
  void initState() {
FirebaseAdMob.instance.initialize(appId: appId);
    //Change appId With Admob Id
    _bannerAd = createBannerAd()
      ..load()
      ..show();

    super.initState();
  }

 @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd.dispose();
    super.dispose();
    
  }
 
  

  String abcd = "";
  TextEditingController mycontroller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final toul = MediaQuery.of(context).size.height;
    final orth = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Color.fromRGBO(51, 73, 95, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(51, 73, 95, 1),
          title: Text(
            "Today's Weather",
            style: TextStyle(fontFamily: 'Tajawal'),
          ),
          //  elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(
                  Icons.cached,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  createInterstitialAd()..load()..show();
                  
                  setState(() {
                    clicked = false;
                    city = "";
                    items = true;
                    mycontroller.text = "";
                  });
                })
          ],
          leading: IconButton(
              icon: Icon(
                Icons.read_more,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                CoolAlert.show(
                  context: context,
                  title: "Caution",
                  type: CoolAlertType.info,
                  text:
                      "Welcome to the caution area, First of all, the city should be known by our servers which means search about countries, capitals, cities... Do not search about sub-city, please.You can also search by providing any adresse ip Have nice weather.",
                );
              }),
        ),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Image.asset("images/weather.gif"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Container(
                  width: orth,
                  height: toul - 200,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                          topRight: Radius.circular(60))),
                ),
              ),
              Positioned(
                  top: 250,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      width: orth - 60,
                      height: toul - 250,
                      decoration: BoxDecoration(
                           //border: Border.all(width: 1,color:Colors.grey),
                          ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Visibility(
                            visible: items,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 1),
                              child: Container(
                                  width: orth - 80,
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      //border: Border.all(width: 1,color:Colors.grey),
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 5,
                                          color: Color.fromRGBO(51, 73, 95, 1),
                                        )
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, top: 8.0),
                                    child: TextField(
                                      keyboardType: TextInputType.name,
                                      controller: mycontroller,
                                      onChanged: (value) {
                                        setState(() {
                                          city = value;
                                        });
                                      },
                                      decoration: InputDecoration(

                                        
                                        
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                            fontFamily: 'Tajawal',
                                          ),
                                          hintText: "Enter a city name"),
                                     
                                    ),
                                  )),
                            ),
                          ),
                          //  FadeInImage(placeholder: null, image: null,D),
                          Visibility(
                            visible: items,
                            child: Container(
                                width: orth - 80,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color.fromRGBO(51, 73, 95, 1),
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 5,
                                        color: Color.fromRGBO(51, 73, 95, 1),
                                      )
                                    ]),
                                child: InkWell(
                                  child: Center(
                                      child: Text("Show Weather",
                                          style: TextStyle(
                                              fontFamily: 'Tajawal',
                                              color: Colors.white,
                                              fontSize: 20))),
                                  onTap: () async {
                                    var result = await Connectivity()
                                        .checkConnectivity();
                                    setState(() {
                                      if (mycontroller.text.isEmpty) {
                                        _scaffoldKey.currentState.showSnackBar(
                                            new SnackBar(
                                                backgroundColor:
                                                    Colors.red[600],
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                content: Row(
                                                  children: [
                                                    Icon(Icons.error),
                                                    SizedBox(width: 30),
                                                    Text(
                                                        "City field cannot be empty!"),
                                                  ],
                                                )));
                                      } else if (result ==
                                          ConnectivityResult.none) {
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          title: "Network Error",
                                          text:"Couldn't show weather. Make sure your phone has an Internet connection and try again.",
                                        );
                                      } else {

                                        clicked = true;
                                        city = "";
                                        items = false;
                                        // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Dur.ctrl(city)));

                                      }
                                    });
                                  },
                                )),
                          ),
                          SizedBox(height: 15),

                          //Text("$city",style:Theme.of(context).textTheme.headline5),

                          SizedBox(height: 70),
                          
                        ],
                      ))),
              clicked ? Dur.ctrl(mycontroller.text) : Column()
            ],
          ),
        ));
  }
}

class Dur extends StatefulWidget {
  @override
  _DurState createState() => _DurState();
  final String country;
  Dur.ctrl(this.country);
}

class _DurState extends State<Dur> {
  String ch, cp;

  Future<Location> location;
  Future<Global> global;
  Future<Condition> condition;
  Future<Current> current;
  Map<String, dynamic> finalResult;

  String country;
  bool vis = true;
  @override
  void initState() {
    super.initState();
    country = widget.country;
    location = getPostById(country);
    global = getPostByGlobal(country);
    condition = getPostByCondition(country);
    current = getPostByCurrent(country);
    // finalResult=mixing(location,global,condition,current);
  }

  String url =
      "http://api.weatherapi.com/v1/current.json?key=f29119a205b3473281074636200112&q=Paris";

  @override
  Widget build(BuildContext context) {
    final toul = MediaQuery.of(context).size.height;
    final orth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        FutureBuilder(
            future: Future.delayed(Duration(seconds: 4)),
            builder: (context, snapshot) {
// Checks whether the future is resolved, ie the duration is over
              if (snapshot.connectionState == ConnectionState.done)
                return Container(
                    decoration: BoxDecoration(
                        //  border: Border.all(width: 1, color: Colors.black),
                        //color: Colors.white,
                        ),
                    margin: EdgeInsets.only(top: 255, left: 10),
                    width: orth,
                    height: toul - 280,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder<Location>(
                              future: location,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "Region : ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Tajawal',
                                            color: Colors.black)),
                                    TextSpan(
                                        text: snapshot.data.name +
                                            " " +
                                            snapshot.data.region +
                                            " " +
                                            snapshot.data.country,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Tajawal',
                                            color: Colors.black)),
                                    TextSpan(text:"\n"),

                                            TextSpan(
                                        text: "Localtime : ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Tajawal',
                                            color: Colors.black)),
                                    TextSpan(
                                        text: snapshot.data.localtime,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Tajawal',
                                            color: Colors.black)),
                                  ]));
                                } else if (!snapshot.hasData) {
                                  return Errorone();
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(top: 305),
                                  child: Image.asset("images/loading.gif"),
                                );
                              }),
                          //********************************* */
                         
                          /***************** */
                          FutureBuilder<Condition>(
                              future: condition,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "Condition : ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Tajawal',
                                            color: Colors.black)),
                                    TextSpan(
                                        text: snapshot.data.text,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Tajawal',
                                            color: Colors.black)),
                                  ]));
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return SizedBox(height: 1);
                              }),
                          /*Padding(
                          padding: const EdgeInsets.only(top: 305),
                          child: Image.asset("images/loading.gif"),
                        ); */
                          //******************** */
                          FutureBuilder<Current>(
                              future: current,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: "Temperature : ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Tajawal',
                                            color: Colors.black)),
                                    TextSpan(
                                        text: snapshot.data.tempc.toString() +
                                            " C | " +
                                            snapshot.data.tempf.toString() +
                                            " F",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'Tajawal',
                                            color: Colors.black)),
                                  ]));
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return SizedBox(height: 1);
                              }),
                          //*************************mmmm */
                          FutureBuilder<Global>(
                              future: global,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "Wind Speed :  ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Tajawal',
                                                color: Colors.black)),
                                        TextSpan(
                                            text: snapshot.data.windkph
                                                    .toString() +
                                                " kp/h",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Tajawal',
                                                color: Colors.black)),
                                      ])),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "Wind Degree :  ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Tajawal',
                                                color: Colors.black)),
                                        TextSpan(
                                            text: snapshot.data.winddegree
                                                    .toString() +
                                                "°",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Tajawal',
                                                color: Colors.black)),
                                      ])),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "Wind Direction :  ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Tajawal',
                                                color: Colors.black)),
                                        TextSpan(
                                            text: snapshot.data.winddir
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Tajawal',
                                                color: Colors.black)),
                                      ])),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "Humidity :  ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Tajawal',
                                                color: Colors.black)),
                                        TextSpan(
                                            text: snapshot.data.humidity
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Tajawal',
                                                color: Colors.black)),
                                      ])),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "Cloud :  ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Tajawal',
                                                color: Colors.black)),
                                        TextSpan(
                                            text:
                                                snapshot.data.cloud.toString(),
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Tajawal',
                                                color: Colors.black)),
                                      ])),
                                    ],
                                  );
                                } else if (snapshot.hasError) {
                                  return Text("${snapshot.error}");
                                }
                                return SizedBox(height: 1);
                              }),
                          // Text("$cou",style:Theme.of(context).textTheme.headline3),
                        ],
                      ),
                    ));
              else
                return Padding(
                  padding: const EdgeInsets.only(top: 305),
                  child: Image.asset("images/loading.gif"),
                ); // Return empty container to avoid build errors
            }),
      ],
    );
  }

  Future<Location> getPostById(String country) async {
    http.Response globalResponse = await http.get(
        "http://api.weatherapi.com/v1/current.json?key=f29119a205b3473281074636200112&q=$country");

    if (globalResponse.statusCode == 200) {
      return Location.fromJSON(json.decode(globalResponse.body));
    } else if (globalResponse.statusCode == 400) {
      Errorone();
    } else {
      throw Exception('Cant not find this region/country');
    }
  }

  /// ************************************* */

  Future<Global> getPostByGlobal(String country) async {
    http.Response globalResponse = await http.get(
        "http://api.weatherapi.com/v1/current.json?key=f29119a205b3473281074636200112&q=$country");

    if (globalResponse.statusCode == 200) {
      return Global.fromJSON(json.decode(globalResponse.body));
    } else if (globalResponse.statusCode == 400) {
      Errorone();
    } else {
      throw Exception('Cant not find this region/country');
    }
  }

  // /****************************** */
  Future<Current> getPostByCurrent(String country) async {
    http.Response globalResponse = await http.get(
        "http://api.weatherapi.com/v1/current.json?key=f29119a205b3473281074636200112&q=$country");

    if (globalResponse.statusCode == 200) {
      return Current.fromJSON(json.decode(globalResponse.body));
    } else if (globalResponse.statusCode == 400) {
      Errorone();
    } else {
      throw Exception('Cant not find this region/country');
    }
  }

  //  /************************** */
  Future<Condition> getPostByCondition(String country) async {
    http.Response globalResponse = await http.get(
        "http://api.weatherapi.com/v1/current.json?key=f29119a205b3473281074636200112&q=$country");

    if (globalResponse.statusCode == 200) {
      return Condition.fromJSON(json.decode(globalResponse.body));
    } else if (globalResponse.statusCode == 400) {
      Errorone();
    } else {
      throw Exception('Cant not find this region/country');
    }
  }
}

class Errorone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Center(
            child: Text(
          "No matching location found.",
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Tajawal',
              color: Colors.redAccent),
        )));
  }
}
