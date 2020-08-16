import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mo8tarib/Screen/dashboard/search_result.dart';
import 'package:mo8tarib/component/search_components.dart';
import 'package:mo8tarib/global.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:mo8tarib/model/property_model.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _fireStore = Firestore.instance;

  String type;
  String category;

  Color anyButton = Colors.white;
  Color houseButton = Colors.white;
  Color flatButton = Colors.white;
  Color roomButton = Colors.white;

  Color inactive = Colors.white;

  Color generalButton = Colors.white;
  Color summerButton = Colors.white;
  Color goAnBackButton = Colors.white;
  Color studentButton = Colors.white;

  DocumentSnapshot _currentDocument;

  void updateColorType(int x) {
    if (x == 1) {
      if (anyButton == inactive) {
        anyButton = foregroundColor;
        houseButton = inactive;
        flatButton = inactive;
        roomButton = inactive;
      } else {
        anyButton = inactive;
      }
    } else if (x == 2) {
      if (houseButton == inactive) {
        houseButton = foregroundColor;
        anyButton = inactive;
        flatButton = inactive;
        roomButton = inactive;
      } else {
        houseButton = inactive;
      }
    } else if (x == 3) {
      if (flatButton == inactive) {
        flatButton = foregroundColor;
        houseButton = inactive;
        anyButton = inactive;
        roomButton = inactive;
      } else {
        flatButton = inactive;
      }
    } else {
      if (roomButton == inactive) {
        roomButton = foregroundColor;
        houseButton = inactive;
        flatButton = inactive;
        anyButton = inactive;
      } else {
        roomButton = inactive;
      }
    }
  }

  void updateColorCategory(int x) {
    if (x == 1) {
      if (generalButton == inactive) {
        generalButton = foregroundColor;
        summerButton = inactive;
        goAnBackButton = inactive;
        studentButton = inactive;
      } else {
        generalButton = inactive;
      }
    } else if (x == 2) {
      if (summerButton == inactive) {
        summerButton = foregroundColor;
        generalButton = inactive;
        goAnBackButton = inactive;
        studentButton = inactive;
      } else {
        summerButton = inactive;
      }
    } else if (x == 3) {
      if (goAnBackButton == inactive) {
        goAnBackButton = foregroundColor;
        generalButton = inactive;
        summerButton = inactive;
        studentButton = inactive;
      } else {
        goAnBackButton = inactive;
      }
    } else {
      if (studentButton == inactive) {
        studentButton = foregroundColor;
        generalButton = inactive;
        summerButton = inactive;
        goAnBackButton = inactive;
      } else {
        studentButton = inactive;
      }
    }
  }

  RangeValues priceValues = RangeValues(300, 5000);
  RangeLabels priceLabels = RangeLabels('300', '5000');

  RangeValues sizeValues = RangeValues(10, 600);
  RangeLabels sizeLabels = RangeLabels('10', '600');

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(new Duration(days: 7));

  Future displayDateRange(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: startDate,
      initialLastDate: endDate,
      firstDate: new DateTime(DateTime.now().year - 5),
      lastDate: new DateTime(DateTime.now().year + 5),
    );
    if (picked != null && picked.length == 2) {
      print(picked);
      setState(() {
        startDate = picked[0];
        endDate = picked[1];
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      //height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("property type",
                                style: TextStyle(
                                    fontSize: 24, fontFamily: 'VarelaRound')),
                            SizedBox(
                              height: 18,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: SearchRaisedButton(
                                    title: 'Any',
                                    textColor: Colors.black,
                                    color: anyButton,
                                    function: () {
                                      setState(() {
                                        updateColorType(1);
                                        type = 'Any';
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: SearchRaisedButton(
                                    title: 'House',
                                    textColor: Colors.black,
                                    color: houseButton,
                                    function: () {
                                      setState(() {
                                        updateColorType(2);
                                        type = 'House';
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: SearchRaisedButton(
                                    title: 'Flat',
                                    textColor: Colors.black,
                                    color: flatButton,
                                    function: () {
                                      setState(() {
                                        updateColorType(3);
                                        type = 'flat';
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: SearchRaisedButton(
                                    title: 'Room',
                                    textColor: Colors.black,
                                    color: roomButton,
                                    function: () {
                                      setState(() {
                                        updateColorType(4);
                                        type = 'Room';
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      //height: 150,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("property Category",
                                style: TextStyle(
                                    fontSize: 24, fontFamily: 'VarelaRound')),
                            SizedBox(
                              height: 18,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: SearchRaisedButton(
                                    title: 'generl',
                                    textColor: Colors.black,
                                    color: generalButton,
                                    function: () {
                                      setState(() {
                                        updateColorCategory(1);
                                        category = 'general';
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: SearchRaisedButton(
                                    title: 'summer',
                                    textColor: Colors.black,
                                    color: summerButton,
                                    function: () {
                                      setState(() {
                                        updateColorCategory(2);
                                        category = 'summer';
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: SearchRaisedButton(
                                    title: 'go and back',
                                    textColor: Colors.black,
                                    color: goAnBackButton,
                                    function: () {
                                      setState(() {
                                        updateColorCategory(3);
                                        category = 'go and back';
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: SearchRaisedButton(
                                    title: 'student',
                                    textColor: Colors.black,
                                    color: studentButton,
                                    function: () {
                                      setState(() {
                                        updateColorCategory(4);
                                        category = 'Student';
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Price daily",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'VarelaRound')),
                                Text(
                                    "${priceValues.start.round()}\$ - ${priceValues.end.round()}\$",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'VarelaRound')),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            RangeSlider(
                              min: 100,
                              max: 5000,
                              divisions: 9000,
                              activeColor: foregroundColor,
                              inactiveColor: backgroundColor1.withOpacity(0.3),
                              values: priceValues,
                              labels: priceLabels,
                              onChanged: (value) {
                                setState(() {
                                  priceValues = value;
                                  priceLabels = RangeLabels(
                                      '${value.start.toInt().toString()}\$',
                                      '${value.end.toInt().toString()}\$');
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("Property Size",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'VarelaRound')),
                                Text(
                                    "${sizeValues.start.round()}m - ${sizeValues.end.round()}m",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'VarelaRound')),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            RangeSlider(
                              min: 10,
                              max: 1000,
                              divisions: 9000,
                              activeColor: foregroundColor,
                              inactiveColor: backgroundColor1.withOpacity(0.3),
                              values: sizeValues,
                              labels: sizeLabels,
                              onChanged: (value) {
                                setState(() {
                                  sizeValues = value;
                                  sizeLabels = RangeLabels(
                                      '${value.start.toInt().toString()}\$',
                                      '${value.end.toInt().toString()}\$');
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("date",
                                style: TextStyle(
                                    fontSize: 24, fontFamily: 'VarelaRound')),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ButtonTheme(
                                  child: RaisedButton.icon(
                                    onPressed: () async {
                                      await displayDateRange(context);
                                    },
                                    icon: Icon(
                                      FontAwesomeIcons.calendarAlt,
                                      size: 20,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    color: Colors.white,
                                    label: Text(
                                      'date',
                                      style: TextStyle(
                                          fontFamily: 'VarelaRound',
                                          color: Colors.black),
                                    ),
                                  ),
                                  minWidth: 150,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text('From'),
                                    Text(
                                        "${DateFormat('dd/MM/yyyy').format(startDate).toString()}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'VarelaRound')),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text('To'),
                                    Text(
                                        "${DateFormat('dd/MM/yyyy').format(endDate).toString()}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: 'VarelaRound')),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 300,
                      //  color: Colors.red,
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SearchRaisedButton(
                        title: 'Clear',
                        textColor: Colors.black,
                        color: Colors.white,
                        function: () {
                          setState(() {
                            anyButton = inactive;
                            houseButton = inactive;
                            flatButton = inactive;
                            roomButton = inactive;
                            summerButton = inactive;
                            goAnBackButton = inactive;
                            generalButton = inactive;
                            studentButton = inactive;
                            priceValues = RangeValues(100, 4000);
                            sizeValues = RangeValues(50, 500);
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: SearchRaisedButton(
                        title: 'Find',
                        color: foregroundColor,
                        textColor: Colors.white,
                        function: () async {
                          List<String> result = [];
                          result = getData();
                          Timer(Duration(seconds: 3), () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SearchResult(
                                    result: result,
                                  ),
                                ));
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  List<String> getData() {
    List<String> result = [];
    print(type);
    print(category);
    _fireStore
        .collection('flat')
        .where("type", isEqualTo: type)
        .where("category", isEqualTo: category)
        .snapshots()
        .listen(
          (data) => data.documents.forEach((doc) {
            print(doc.documentID);
            result.add(doc.documentID);
            print(result);
          }),
        );
    print(priceValues.end.toInt().toString());
    print(priceValues.start.toInt().toString());
    print('///////////////');
    print(result);
    return result;
  }
}
