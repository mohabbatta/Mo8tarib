import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mo8tarib/app/Screen/property/pending_proprty.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/common_widgets/allHomeComponent/imageFlatWidget.dart';
import 'package:mo8tarib/app/common_widgets/resuable_edit_user.dart';
import 'package:mo8tarib/app/common_widgets/search_components.dart';
import 'package:mo8tarib/global.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:geolocator/geolocator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mo8tarib/servies/data_base.dart';
import 'package:provider/provider.dart';

class AddProperty extends StatefulWidget {
  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  String dropdownTypeValue = 'Any';
  String dropdownCategoryValue = 'Any';

  int price = 100;

  String description;
  String size;

  var electricity = false;
  var furniture = false;
  var water = false;
  var animal = false;
  var des = false;
  var gas = false;
  var url;

  String rooms = '0';
  String bathroom = '0';
  String kitchen = '0';
  String locationText = 'press button';
  String genderText;
  String govText;
  String cityText;

  TextEditingController descriptionController;
  TextEditingController sizeController;
  TextEditingController roomsController;
  TextEditingController bathroomController;
  TextEditingController kitchenController;
  TextEditingController locationController;
  TextEditingController genderController;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(new Duration(days: 7));

  List<String> services = [];

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

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position currentPosition;
  Position getPosition;
  GeoPoint geoPoint;

  String currentAddress;

  getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      print(position);
      setState(() {
        currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        govText = place.administrativeArea;
        cityText = place.subAdministrativeArea;
        locationText = " ${place.name}, $cityText";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    descriptionController = TextEditingController(text: description);
    sizeController = TextEditingController(text: size);
    roomsController = TextEditingController(text: rooms);
    bathroomController = TextEditingController(text: bathroom);
    kitchenController = TextEditingController(text: kitchen);
    locationController = TextEditingController(text: locationText);
    genderController = TextEditingController(text: genderText);
    // getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    descriptionController.dispose();
    sizeController.dispose();
    roomsController.dispose();
    bathroomController.dispose();
    kitchenController.dispose();
    locationController.dispose();
    genderController.dispose();
    super.dispose();
  }

  String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

  Future<void> addProperty(BuildContext context) async {
    final user = Provider.of<User>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);

    final id = user?.uid;
    final pid = documentIdFromCurrentDate();
    final newProperty = Property(
      pid: pid,
      uid: id,
      type: dropdownTypeValue,
      category: dropdownCategoryValue,
      gender: genderController.text,
      kitchen: kitchenController.text,
      imageUrls: imageUrls,
      bathRooms: bathroomController.text,
      description: descriptionController.text,
      price: price.toString(),
      rooms: roomsController.text,
      services: services,
      size: sizeController.text,

      //          'UID': loggedInUser.uid,
//          'type': dropdownTypeValue,
//          'category': dropdownCategoryValue,
//          'price': price.toString(),
//          'description': descriptionController.text,
//          'size': sizeController.text,
//          'serives': services,
//          'rooms': roomsController.text,
//          'bathroom': bathroomController.text,
//          'kitchen': kitchenController.text,
//          'Gender': genderController.text,
//          'timestart': DateFormat('dd/MM/yyyy').format(startDate).toString(),
//          'timeend': DateFormat('dd/MM/yyyy').format(endDate).toString(),
//          'government': govText,
//          'city': cityText,
//          'address': locationText,
//          'Location': [currentPosition.latitude, currentPosition.longitude],
//          'imagesUrl': imageUrls,
    );
    await database.setProperty(newProperty);
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => PendingProperty(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Property Type",
                      style:
                          TextStyle(fontSize: 22, fontFamily: 'VarelaRound')),
                ),
                DropdownButton<String>(
                  value: dropdownTypeValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 20,
                  elevation: 16,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'VarelaRound',
                      color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: foregroundColor,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownTypeValue = newValue;
                    });
                  },
                  items: <String>['Any', 'House', 'Flat', 'Room']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Category",
                      style:
                          TextStyle(fontSize: 22, fontFamily: 'VarelaRound')),
                ),
                DropdownButton<String>(
                  value: dropdownCategoryValue,
                  icon: Icon(Icons.arrow_downward),
                  iconSize: 20,
                  elevation: 16,
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'VarelaRound',
                      color: Colors.black),
                  underline: Container(
                    height: 2,
                    color: foregroundColor,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownCategoryValue = newValue;
                    });
                  },
                  items: <String>[
                    'Any',
                    'Summer',
                    'go and back',
                    'Student',
                    'general'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
            SizedBox(height: 10),
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
                                fontSize: 24, fontFamily: 'VarelaRound')),
                        Text(price.toString() + " \$ ",
                            style: TextStyle(
                                fontSize: 20, fontFamily: 'VarelaRound')),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Slider(
                        activeColor: foregroundColor,
                        inactiveColor: Colors.black.withOpacity(0.3),
                        value: price.toDouble(),
                        min: 0,
                        max: 5000,
                        onChanged: (double newValue) {
                          setState(() {
                            price = newValue.round();
                          });
                        }),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            ReusableEditUser(
              controller: descriptionController,
              hint: 'description',
              textFieldName: "description",
              getText: (value) {
                description = value;
              },
            ),
            SizedBox(height: 10),
            ReusableEditUser(
              controller: sizeController,
              hint: 'size',
              textFieldName: "size",
              getText: (value) {
                size = value;
              },
            ),
            SizedBox(height: 10),
            ReusableEditUser(
              controller: genderController,
              hint: 'gender',
              textFieldName: "gender",
              getText: (value) {
                genderText = value;
              },
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Service",
                      style:
                          TextStyle(fontSize: 20, fontFamily: 'VarelaRound')),
                ),
                DropdownButton(
                  items: [
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            onChanged: (bool value) {
                              setState(() {
                                electricity = value;
                                if (value == true) {
                                  if (!services.contains('electricity')) {
                                    services.add('electricity');
                                  }
                                } else {
                                  services.remove('electricity');
                                }
                              });
                            },
                            tristate: false,
                            value: electricity,
                          ),
                          Text('electricity'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            onChanged: (bool value) {
                              setState(() {
                                furniture = value;
                                if (value == true) {
                                  if (!services.contains('furniture')) {
                                    services.add('furniture');
                                  }
                                } else {
                                  services.remove('furniture');
                                }
                              });
                            },
                            value: furniture,
                          ),
                          Text('furniture'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            onChanged: (bool value) {
                              setState(() {
                                water = value;
                                if (value == true) {
                                  services.add('water');
                                } else {
                                  services.remove('water');
                                }
                              });
                            },
                            value: water,
                          ),
                          Text('water'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            onChanged: (bool value) {
                              setState(() {
                                animal = value;
                                if (value == true) {
                                  services.add('animal');
                                } else {
                                  services.remove('animal');
                                }
                              });
                            },
                            value: animal,
                          ),
                          Text('animal'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            onChanged: (bool value) {
                              setState(() {
                                des = value;
                                if (value == true) {
                                  services.add('des');
                                } else {
                                  services.remove('des');
                                }
                              });
                            },
                            value: des,
                          ),
                          Text('des'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      child: Row(
                        children: <Widget>[
                          Checkbox(
                            onChanged: (bool value) {
                              setState(() {
                                gas = value;
                                if (value == true) {
                                  services.add('gas');
                                } else {
                                  services.remove('gas');
                                }
                              });
                            },
                            value: gas,
                          ),
                          Text('gas'),
                        ],
                      ),
                    )
                  ],
                  onChanged: (value) {},
                  hint: Text('Select value'),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Rooms')),
                Expanded(
                  child: TextField(
                    controller: roomsController,
                    onChanged: (value) {
                      setState(() {
                        rooms = value;
                      });
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Bathroom')),
                Expanded(
                  child: TextField(
                    controller: bathroomController,
                    onChanged: (value) {
                      setState(() {
                        bathroom = value;
                      });
                    },
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Kitchen')),
                Expanded(
                  child: TextField(
                    controller: kitchenController,
                    onChanged: (value) {
                      kitchen = value;
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("date",
                        style:
                            TextStyle(fontSize: 20, fontFamily: 'VarelaRound')),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('From'),
                            Text(
                                "${DateFormat('dd/MM/yyyy').format(startDate).toString()}",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'VarelaRound')),
                            SizedBox(
                              height: 15,
                            ),
                            Text('To'),
                            Text(
                                "${DateFormat('dd/MM/yyyy').format(endDate).toString()}",
                                style: TextStyle(
                                    fontSize: 20, fontFamily: 'VarelaRound')),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'location',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            locationText,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.location_on,
                              color: foregroundColor,
                            ),
                            onPressed: getCurrentLocation)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: FlatButton(
                onPressed: () {
                  openFileExplorer();
                },
                child: Text(
                  'Add Picters',
                  // localization.translate("Change profile photo"),
                  style: TextStyle(color: foregroundColor),
                ),
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Container(
              child: SizedBox(
                height: 150,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) => imageFlatWidget(
                    image: NetworkImage(imageUrls[index]),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            SearchRaisedButton(
              color: foregroundColor,
              textColor: Colors.white,
              title: 'Add',
              function: () async {
                await addProperty(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  ///
  List<String> imageUrls = <String>[];
  Map<String, String> _paths;
  String _extension;

  void openFileExplorer() async {
    try {
      _paths = await FilePicker.getMultiFilePath(type: FileType.image);
      uploadToFirebase();
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
  }

  uploadToFirebase() {
    _paths.forEach((fileName, filePath) => {upload(fileName, filePath)});
  }

  upload(fileName, filePath) async {
    _extension = fileName.toString().split('.').last;
    StorageReference storageRef =
        FirebaseStorage.instance.ref().child(fileName);
    final StorageUploadTask uploadTask = storageRef.putFile(
      File(filePath),
      StorageMetadata(
        contentType: '$FileType.image/$_extension',
      ),
    );
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String getUrl = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      imageUrls.add(getUrl);
    });
    print(imageUrls);
  }
}
