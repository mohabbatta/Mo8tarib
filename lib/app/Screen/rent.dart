import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mo8tarib/app/common_widgets/search_components.dart';

import 'package:mo8tarib/global.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import 'package:mo8tarib/localization.dart';

class Rent extends StatefulWidget {
  final String flatDocId;
  final String userDocId;

  const Rent({Key key, this.flatDocId, this.userDocId}) : super(key: key);

  @override
  _RentState createState() => _RentState();
}

class _RentState extends State<Rent> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
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
    var size = MediaQuery.of(context).size;
    var localization = AppLocalizations.of(context);
    String name = 'ali';

    return MaterialApp(
      title: 'Flutter Credit Card View Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('flat')
              .doc(widget.flatDocId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Text("Loading");
            }
            var flatDocument = snapshot.data;

            print(flatDocument['url']);

            return Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  'Rent',
                  style: TextStyle(
                    color: foregroundColor,
                  ),
                ),
                leading: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      size: 30,
                      color: foregroundColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (context) => DashBoardLayout()));
                    }),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('user')
                          .doc(widget.userDocId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return new Text("Loading");
                        }
                        var userDocument = snapshot.data;

                        print(userDocument['url']);
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Center(
                                child: Text(
                                  'you must pay the insurance 500 ',
                                  style: TextStyle(fontSize: 24),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 15, 0),
//                                    child: Avatar(radius: 20,photoUrl: ,),
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                            '${userDocument['name']['first']} ${userDocument['name']['last']}',
                                            style: TextStyle(
                                                color: color1, fontSize: 18)),
                                        Text('Owner',
                                            style: TextStyle(
                                                color: color1, fontSize: 18)),
                                      ],
                                    ),
                                  ),
                                  Text('\$',
                                      style: TextStyle(
                                          fontFamily: 'VarelaRound',
                                          fontSize: 30)),
                                  Text(flatDocument['price'],
                                      //flatDocument['price'],
                                      style: TextStyle(
                                          fontFamily: 'VarelaRound',
                                          fontSize: 30)),
                                  Text(' / day',
                                      style: TextStyle(
                                          fontFamily: 'VarelaRound',
                                          fontSize: 20))
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                            Text(flatDocument['timestart'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'VarelaRound')),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Text('To'),
                                            Text(flatDocument['timeend'],
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontFamily: 'VarelaRound')),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Total price',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                  Text('Total price'),
                                ],
                              ),
                            ),
                            CreditCardWidget(
                              cardNumber: cardNumber,
                              expiryDate: expiryDate,
                              cardHolderName: cardHolderName,
                              cvvCode: cvvCode,
                              showBackView: isCvvFocused,
                            ),
                            Container(
                              child: CreditCardForm(
                                onCreditCardModelChange:
                                    onCreditCardModelChange,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: SearchRaisedButton(
                                color: foregroundColor,
                                title: 'pay',
                                textColor: Colors.white,
                                function: () {},
                              ),
                            )
                          ],
                        );
                      }),
                ),
              ),
            );
          }),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  DateTime convertDateFromString(String strDate) {
    DateTime todayDate = DateTime.parse(strDate);
    return todayDate;
  }
}
