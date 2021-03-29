import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mo8tarib/app/Screen/dashboard/property/add_propert_model.dart';
import 'package:mo8tarib/app/Screen/dashboard/property/add_property_bloc.dart';

class DatePicker extends StatelessWidget {
  final AddPropertyBloc bloc;
  final AddPropertyModel model;
  const DatePicker({Key key, this.bloc, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("date",
                style: TextStyle(fontSize: 20, fontFamily: 'VarelaRound')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButtonTheme(
                  child: RaisedButton.icon(
                    onPressed: () async {
                      await bloc.displayDateRange(context);
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
                          fontFamily: 'VarelaRound', color: Colors.black),
                    ),
                  ),
                  minWidth: 150,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('From'),
                    Text(
                        "${DateFormat('dd/MM/yyyy').format(model.startDateTime()).toString()}",
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'VarelaRound')),
                    SizedBox(
                      height: 15,
                    ),
                    Text('To'),
                    Text(
                        "${DateFormat('dd/MM/yyyy').format(model.endDateTime()).toString()}",
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'VarelaRound')),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
