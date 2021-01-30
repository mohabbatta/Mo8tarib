import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:mo8tarib/services/api_path.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';

class PendingProperty extends StatefulWidget {
  @override
  _PendingPropertyState createState() => _PendingPropertyState();
}

class _PendingPropertyState extends State<PendingProperty> {
  DocumentSnapshot _currentDocument;
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

//  void addData(BuildContext context) {
//    if (int.parse(ageText) < 17) {
//      final snackBar =
//          SnackBar(content: Text('you can\'t go   with your age under 18'));
//      Scaffold.of(context).showSnackBar(snackBar);
//    } else {
//      if (url == null) {
//        final snackBar = SnackBar(content: Text('Please Complete your data'));
//        Scaffold.of(context).showSnackBar(snackBar);
//      } else {
//        _fireStore.collection('post').add(
//          {
//            'flat_id': ageText,
//            'time': emailText,
//            'user_id': phoneText,
//          },
//        );
//        Navigator.pushNamed(context, '/home');
//      }
//    }
////    final snackBar =
////    SnackBar(content: Text('Information add'));
////    Scaffold.of(context).showSnackBar(snackBar);
//    // Navigator.pushNamed(context, '/home');
//  }

  @override
  Widget build(BuildContext context) {
    final dataBase = Provider.of<Database>(context);
    final user = Provider.of<MyUser>(context);
    return StreamBuilder<List<Property>>(
      stream: dataBase.propertiesStream(user: user),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final list = snapshot.data;
          if (list.isNotEmpty) {
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Card(
                            elevation: 10,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Container(
                              height: 300,
                              child: Column(
                                children: <Widget>[
                                  Flexible(
                                    child: Stack(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fitWidth,
                                              image: NetworkImage(
                                                  list[index].imageUrls[0]),
                                            ),
                                            borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(30)),
                                          ),
                                        ),
                                        Positioned(
                                          top: 10,
                                          right: 10,
                                          child: FloatingActionButton(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.red,
                                              ),
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.5),
                                              onPressed: () async {
                                                final DocumentReference
                                                    reference1 =
                                                FirebaseFirestore.instance.doc(
                                                        APIPath.properties() +
                                                            list[index].pid);
                                                final DocumentReference
                                                    reference2 =
                                                FirebaseFirestore.instance.doc(
                                                        APIPath.usersAll() +
                                                            list[index].uid);
                                                FirebaseFirestore.instance
                                                    .collection('mohab_posts')
                                                    .add(
                                                  {
                                                    'flat_id': reference1,
                                                    'time': DateTime.now(),
                                                    'user_id': reference2,
                                                  },
                                                );
                                                print('post it');
                                                final snackBar = SnackBar(
                                                    content: Text(
                                                        'property posted'));
                                                Scaffold.of(context)
                                                    .showSnackBar(snackBar);
                                              }),
                                        )
                                      ],
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.vertical(
                                              bottom: Radius.circular(30)),
                                          // color: Colors.white.withOpacity(0.5),
                                          gradient: LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              colors: [
                                                Colors.teal,
                                                Colors.indigo
                                              ])),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesomeIcons.mapMarker,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  list[index].address,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Text(
                                                  list[index].type,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  list[index].category,
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )
                                              ],
                                            ),
                                            Text(
                                              list[index].description,
                                              style: TextStyle(fontSize: 18),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  FontAwesomeIcons.dollarSign,
                                                  size: 15,
                                                ),
                                                SizedBox(width: 5),
                                                Text(
                                                  list[index].price.toString(),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                });
          } else {
            return Center(child: Text('Empty'));
          }
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Something went wrong',
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
