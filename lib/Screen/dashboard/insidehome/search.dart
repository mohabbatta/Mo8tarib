import 'package:flutter/material.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  RangeValues priceValues = RangeValues(300, 600);
  RangeLabels priceLabels = RangeLabels('300', '600');

  RangeValues sizeValues = RangeValues(300, 600);
  RangeLabels sizeLabels = RangeLabels('300', '600');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "property type",
              style: TextStyle(
                  fontSize: 24, fontFamily: 'VarelaRound'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10)),
                    color: Colors.indigo,
                    child: Text('Any'),
                    onPressed: () {}),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10)),
                    color: Colors.grey,
                    child: Text('House'),
                    onPressed: () {}),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10)),
                    color: Colors.grey,
                    child: Text('flat'),
                    onPressed: () {}),
                RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10)),
                    color: Colors.grey,
                    child: Text('Room'),
                    onPressed: () {})
              ],
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Price daily",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'VarelaRound')),
                      Text(
                          "${priceValues.start.round()}\$ - ${priceValues.end.round()}\$",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'VarelaRound')),
                    ],
                  ),
                  RangeSlider(
                    min: 100,
                    max: 1000,
                    divisions: 9000,
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
            Container(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Property Size",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'VarelaRound')),
                      Text(
                          "${sizeValues.start.round()}m - ${sizeValues.end.round()}m",
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'VarelaRound')),
                    ],
                  ),
                  RangeSlider(
                    min: 100,
                    max: 1000,
                    divisions: 9000,
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
            )
          ],
        ),
      ),
    );
  }
}