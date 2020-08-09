import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mo8tarib/component/search_components.dart';
import 'package:mo8tarib/global.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  RangeValues priceValues = RangeValues(300, 600);
  RangeLabels priceLabels = RangeLabels('300', '600');

  RangeValues sizeValues = RangeValues(300, 600);
  RangeLabels sizeLabels = RangeLabels('300', '600');

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
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SearchRaisedButton(
                                  title: 'Any',
                                  textColor: Colors.white,
                                  color: foregroundColor,
                                  function: () {},
                                ),
                                SearchRaisedButton(
                                  title: 'House',
                                  textColor: Colors.black,
                                  color: Colors.white,
                                  function: () {},
                                ),
                                SearchRaisedButton(
                                  title: 'Flat',
                                  textColor: Colors.black,
                                  color: Colors.white,
                                  function: () {},
                                ),
                                SearchRaisedButton(
                                  title: 'Room',
                                  textColor: Colors.black,
                                  color: Colors.white,
                                  function: () {},
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
                              max: 1000,
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
                              min: 100,
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
                      color: Colors.red,
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
                          print('clear button');
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
                        function: () {
                          print('Find');
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
}
