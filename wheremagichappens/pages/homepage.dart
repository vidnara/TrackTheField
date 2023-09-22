import 'package:shotput/controllers/databse.dart';
import 'package:shotput/pages/homepage.dart';
import 'package:shotput/pages/models/jdsinfo.dart';
import 'package:shotput/pages/name_change.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'new_value.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //
  late Box box;
  late SharedPreferences preferences;
  JDSInfo dbHelper = JDSInfo();
  Map? data;
  List<FlSpot> dataSet = [];
  List<FlSpot> dataset2 = [];
  List<FlSpot> dataset3 = [];
  DateTime today = DateTime.now();
  DateTime now = DateTime.now();
  int index = 1;

  List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  @override
  void initState() {
    super.initState();
    getPreference();
    box = Hive.box('distances');
  }

  getPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<List<JDSinfo>> fetch() async {
    if (box.values.isEmpty) {
      return Future.value([]);
    } else {
      List<JDSinfo> items = [];
      box.toMap().values.forEach((element) {
        items.add(
          JDSinfo(
            element['distance'] as int,
            element['date'] as DateTime,
            element['type'],
          ),
        );
      });
      return items;
    }
  }
  //

  List<FlSpot> getPlotPoints(List<JDSinfo> entireData) {
    dataSet = [];
    List tempdataSet = [];

    for (JDSinfo item in entireData) {
      if (item.date.month == today.month && item.type == "shotput") {
        tempdataSet.add(item);
      }
    }

    tempdataSet.sort((a, b) => a.date.day.compareTo(b.date.day));

    for (var i = 0; i < tempdataSet.length; i++) {
      dataSet.add(
        FlSpot(
          tempdataSet[i].date.day.toDouble(),
          tempdataSet[i].distance.toDouble(),
        ),
      );
    }
    return dataSet;
  }

  List<FlSpot> getPlotPoints2(List<JDSinfo> entireData) {
    dataset2 = [];
    List tempdataSet2 = [];

    for (JDSinfo item in entireData) {
      if (item.date.month == today.month && item.type == "Discus") {
        tempdataSet2.add(item);
      }
    }

    tempdataSet2.sort((a, b) => a.date.day.compareTo(b.date.day));

    for (var i = 0; i < tempdataSet2.length; i++) {
      dataset2.add(
        FlSpot(
          tempdataSet2[i].date.day.toDouble(),
          tempdataSet2[i].distance.toDouble(),
        ),
      );
    }
    return dataset2;
  }

  List<FlSpot> getPlotPoints3(List<JDSinfo> entireData) {
    dataset3 = [];
    List tempdataSet3 = [];

    for (JDSinfo item in entireData) {
      if (item.date.month == today.month && item.type == "Javelin") {
        tempdataSet3.add(item);
      }
    }

    tempdataSet3.sort((a, b) => a.date.day.compareTo(b.date.day));

    for (var i = 0; i < tempdataSet3.length; i++) {
      dataset2.add(
        FlSpot(
          tempdataSet3[i].date.day.toDouble(),
          tempdataSet3[i].distance.toDouble(),
        ),
      );
    }
    return dataset3;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        backgroundColor: Colors.white,
        //
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
              CupertinoPageRoute(
                builder: (context) => AddtrackthefieldNoGradient(),
              ),
            )
                .then((value) {
              setState(() {});
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16.0,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 26, 22, 65),
          child: Icon(
            Icons.add_outlined,
            size: 32.0,
          ),
        ),
        //
        body: FutureBuilder<List<JDSinfo>>(
            future: fetch(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "It appears there is an error. Please retry.",
                    style: TextStyle(
                      fontSize: 24.0,
                    ),
                  ),
                );
              }
              if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: Image.asset(
                      "assets/madlogo.png",
                      width: 600,
                    ),
                  );
                }
                getPlotPoints(snapshot.data!);
                getPlotPoints2(snapshot.data!);
                getPlotPoints3(snapshot.data!);
                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                        12.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    32.0,
                                  ),
                                  gradient: LinearGradient(
                                    colors: <Color>[
                                      Color.fromARGB(255, 26, 22, 56),
                                      Color.fromARGB(255, 26, 22, 56),
                                    ],
                                  ),
                                ),
                                child: CircleAvatar(
                                  maxRadius: 28.0,
                                  backgroundColor: Colors.transparent,
                                  child: Image.asset(
                                    "assets/innerlogo.png",
                                    width: 64.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              SizedBox(
                                width: 200.0,
                                child: Text(
                                  "Hello ${preferences.getString('name')}!!",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 26, 22, 65),
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                12.0,
                              ),
                              color: Colors.white70,
                            ),
                            padding: EdgeInsets.all(
                              12.0,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(
                                  MaterialPageRoute(
                                    builder: (context) => NewName(),
                                  ),
                                )
                                    .then((value) {
                                  setState(() {});
                                });
                              },
                              child: Icon(
                                Icons.settings,
                                size: 32.0,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      margin: EdgeInsets.all(
                        12.0,
                      ),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color.fromARGB(255, 26, 22, 65),
                              Color.fromARGB(255, 26, 22, 65),
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              24.0,
                            ),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                24.0,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            vertical: 18.0,
                            horizontal: 8.0,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'TrackTheField - Ensuring Excellence',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //
                    selectMonth(),
                    //

                    Padding(
                      padding: const EdgeInsets.all(
                        12.0,
                      ),
                      child: Text(
                        "Shot Put",
                        style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    dataSet.isEmpty || dataSet.length < 2
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 20.0,
                            ),
                            margin: EdgeInsets.all(
                              12.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: Text(
                              "The whole point of this app is line graphs - you need at least two values each month per event",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        : Container(
                            height: 300.0,
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 12.0,
                            ),
                            margin: EdgeInsets.all(
                              12.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: LineChart(
                              LineChartData(
                                borderData: FlBorderData(
                                  show: true,
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: getPlotPoints(snapshot.data!),
                                    isCurved: true,
                                    barWidth: 5,
                                    colors: [
                                      Color.fromARGB(255, 26, 22, 65),
                                    ],
                                    showingIndicators: [100, 200, 90, 10],
                                    dotData: FlDotData(
                                      show: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                    Padding(
                      padding: const EdgeInsets.all(
                        12.0,
                      ),
                      child: Text(
                        "Discus",
                        style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    dataset2.isEmpty || dataset2.length < 2
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 20.0,
                            ),
                            margin: EdgeInsets.all(
                              12.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: Text(
                              "The whole point of this app is line graphs - you need at least two values each month per event",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        : Container(
                            height: 300.0,
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 12.0,
                            ),
                            margin: EdgeInsets.all(
                              12.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: LineChart(
                              LineChartData(
                                borderData: FlBorderData(
                                  show: true,
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: getPlotPoints2(snapshot.data!),
                                    isCurved: true,
                                    barWidth: 5,
                                    colors: [
                                      Color.fromARGB(255, 26, 22, 65),
                                    ],
                                    showingIndicators: [100, 200, 90, 10],
                                    dotData: FlDotData(
                                      show: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                    Padding(
                      padding: const EdgeInsets.all(
                        12.0,
                      ),
                      child: Text(
                        "Javelin",
                        style: TextStyle(
                          fontSize: 32.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    dataset3.isEmpty || dataset3.length < 2
                        ? Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 20.0,
                            ),
                            margin: EdgeInsets.all(
                              12.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                            child: Text(
                              "The whole point of this app is line graphs - you need at least two values each month per event",
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            ),
                          )
                        : Container(
                            height: 300.0,
                            padding: EdgeInsets.symmetric(
                              vertical: 15.0,
                              horizontal: 12.0,
                            ),
                            margin: EdgeInsets.all(
                              12.0,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: LineChart(
                              LineChartData(
                                borderData: FlBorderData(
                                  show: true,
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: getPlotPoints3(snapshot.data!),
                                    isCurved: true,
                                    barWidth: 5,
                                    colors: [
                                      Color.fromARGB(255, 26, 22, 65),
                                    ],
                                    showingIndicators: [100, 200, 90, 10],
                                    dotData: FlDotData(
                                      show: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ],
                );
              } else {
                return Text(
                  "Loading...",
                );
              }
            }));
  }

  Widget selectMonth() {
    return Padding(
      padding: EdgeInsets.all(
        8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                index = 0;
                today = DateTime(now.year, now.month - 2, today.day);
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color:
                    index == 0 ? Color.fromARGB(255, 26, 22, 65) : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 3],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: index == 0
                      ? Colors.white
                      : Color.fromARGB(255, 26, 22, 65),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                index = 2;
                today = DateTime(now.year, now.month - 1, today.day);
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color:
                    index == 2 ? Color.fromARGB(255, 26, 22, 65) : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 2],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: index == 2
                      ? Colors.white
                      : Color.fromARGB(255, 26, 22, 65),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                index = 1;
                today = DateTime.now();
              });
            },
            child: Container(
              height: 50.0,
              width: MediaQuery.of(context).size.width * 0.3,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                color:
                    index == 1 ? Color.fromARGB(255, 26, 22, 65) : Colors.white,
              ),
              alignment: Alignment.center,
              child: Text(
                months[now.month - 1],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                  color: index == 1
                      ? Colors.white
                      : Color.fromARGB(255, 26, 22, 65),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
