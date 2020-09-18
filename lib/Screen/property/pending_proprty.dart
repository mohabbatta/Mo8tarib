import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/model/property_model.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

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

  final _fireStore = Firestore.instance;
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;
  DocumentReference user_id;
  DocumentReference flat_id;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(user.email);
        //getData();
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
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
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('flat').snapshots(),
      builder: (context, snapshot) {
        propertiesList.clear();
        if (snapshot.hasData) {
          final properties = snapshot.data.documents;
          for (var property in properties) {
            final UID = property.data['UID'];
            if (UID == loggedInUser.uid) {
              flat_id = property.reference;
              _currentDocument = property;

              print('flat id ///// $flat_id');
//
//              _fireStore
//                  .collection('user')
//                  .where("UID", isEqualTo: loggedInUser.uid)
//                  .snapshots()
//                  .listen(
//                    (data) => data.documents.forEach((doc) {
//                      final user_id = doc.reference;
//                      print('user id ///// $user_id');
//                    }),
//                  );

              final price = property.data['price'];
              final address = property.data['address'];
              final url = property.data['imagesUrl'];
              final description = property.data['description'];
              final type = property.data['type'];
              final category = property.data['category'];

              var pro = Property(
                url: url[0],
                address: address,
                description: description,
                category: category,
                type: type,
                price: price,
              );
              propertiesList.add(pro);
            }
          }
          print('${propertiesList.length}    /////');
        } else {
          print('no data found');
        }

        return ListView.builder(
            itemCount: propertiesList.length,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.white,
                child: StreamBuilder<QuerySnapshot>(
                    stream: _fireStore.collection('user').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final users = snapshot.data.documents;
                        for (var user in users) {
                          final UID = user.data['email'];
                          if (UID == loggedInUser.email) {
                            user_id = user.reference;
                            print('user id ///// $user_id');
                          }
                        }
                      } else {
                        print('there no user');
                      }
                      return Padding(
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
                                                    propertiesList[index].url),
                                              ),
                                              borderRadius:
                                                  BorderRadius.vertical(
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
                                                backgroundColor: Colors.white
                                                    .withOpacity(0.5),
                                                onPressed: () async {
                                                  await displayDateRange(
                                                      context);
                                                  print('display range');

                                                  _currentDocument.reference
                                                      .updateData({
                                                    'timeend':
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(endDate)
                                                            .toString(),
                                                  });
                                                  _currentDocument.reference
                                                      .updateData({
                                                    'timestart':
                                                        DateFormat('dd/MM/yyyy')
                                                            .format(startDate)
                                                            .toString(),
                                                  });

                                                  print('update data');
                                                  _fireStore
                                                      .collection('post')
                                                      .add(
                                                    {
                                                      'flat_id': flat_id,
                                                      'time': DateTime.now(),
                                                      'user_id': user_id,
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
                                                    propertiesList[index]
                                                        .address,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text(
                                                    propertiesList[index].type,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    propertiesList[index]
                                                        .category,
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  )
                                                ],
                                              ),
                                              Text(
                                                propertiesList[index]
                                                    .description,
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
                                                    propertiesList[index].price,
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
                      );
                    }),
              );
            });
      },
    );
  }
}
