import 'package:flutter/material.dart';
import 'package:mo8tarib/bloc/navigation_bottom.dart';

class Find extends StatefulWidget {
  @override
  _FindState createState() => _FindState();
}

class _FindState extends State<Find> {
  @override
  Widget build(BuildContext context) {
    String name = 'ali';
    return Container(
      child: Column(
        children: <Widget>[
          Text('$name'),
          RaisedButton(
            onPressed: () {
              setState(() {
                name = 'hussen';
              });
            },
            child: Text('press'),
          ),
        ],
      ),
    );
  }
  // @override
//  Widget build(BuildContext context) {
//    RangeValues priceValues = RangeValues(400, 600);
//    RangeLabels priceLabels = RangeLabels('400', '600');
//
//    RangeValues sizeValues = RangeValues(400, 600);
//    RangeLabels sizeLabels = RangeLabels('400', '600');
//
//    return Container(
//      child: Padding(
//        padding: const EdgeInsets.all(12.0),
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Text(
//              "property type",
//              style: TextStyle(fontSize: 24, fontFamily: 'VarelaRound'),
//            ),
//            Row(
//              mainAxisAlignment: MainAxisAlignment.spaceAround,
//              children: <Widget>[
//                RaisedButton(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10)),
//                    color: Colors.indigo,
//                    child: Text('Any'),
//                    onPressed: () {}),
//                RaisedButton(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10)),
//                    color: Colors.grey,
//                    child: Text('House'),
//                    onPressed: () {}),
//                RaisedButton(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10)),
//                    color: Colors.grey,
//                    child: Text('flat'),
//                    onPressed: () {}),
//                RaisedButton(
//                    shape: RoundedRectangleBorder(
//                        borderRadius: BorderRadius.circular(10)),
//                    color: Colors.grey,
//                    child: Text('Room'),
//                    onPressed: () {})
//              ],
//            ),
//            Container(
//              child: Column(
//                children: <Widget>[
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text("Price daily",
//                          style: TextStyle(
//                              fontSize: 20, fontFamily: 'VarelaRound')),
//                      Text(
//                          "${priceValues.start.round()}\$ - ${priceValues.end.round()}\$",
//                          style: TextStyle(
//                              fontSize: 20, fontFamily: 'VarelaRound')),
//                    ],
//                  ),
//                  RangeSlider(
//                    min: 100,
//                    max: 1000,
//                    divisions: 9000,
//                    values: priceValues,
//                    labels: priceLabels,
//                    onChanged: (value) {
//                      setState(() {
//                        priceValues = value;
//                        priceLabels = RangeLabels(
//                            '${value.start.toInt().toString()}\$',
//                            '${value.end.toInt().toString()}\$');
//                      });
//                    },
//                  ),
//                ],
//              ),
//            ),
//            Container(
//              child: Column(
//                children: <Widget>[
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text("Property Size",
//                          style: TextStyle(
//                              fontSize: 20, fontFamily: 'VarelaRound')),
//                      Text(
//                          "${sizeValues.start.round()}m - ${sizeValues.end.round()}m",
//                          style: TextStyle(
//                              fontSize: 20, fontFamily: 'VarelaRound')),
//                    ],
//                  ),
//                  RangeSlider(
//                    min: 100,
//                    max: 1000,
//                    divisions: 9000,
//                    values: sizeValues,
//                    labels: sizeLabels,
//                    onChanged: (value) {
//                      setState(() {
//                        sizeValues = value;
//                        sizeLabels = RangeLabels(
//                            '${value.start.toInt().toString()}\$',
//                            '${value.end.toInt().toString()}\$');
//                      });
//                    },
//                  ),
//                ],
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//

//      Container(
//      color: Colors.amber,
//      child: Container(
//        width: 200,
//        height: 200,
//        child: Slider(
//            value: height.toDouble(),
//            min: 0,
//            max: 220,
//            onChanged: (double newValue) {
//              setState(() {
//                height = newValue.round();
//              });
//            }),
//      ),
//    );

}
