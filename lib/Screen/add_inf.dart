import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mo8tarib/component/resuable_edit_user.dart';
import 'package:mo8tarib/global.dart';
import 'package:mo8tarib/localization.dart';
import 'package:path/path.dart';

//firebase.auth()
//.signInWithEmailAndPassword('you@domain.com', 'correcthorsebatterystaple')
//.then(function(userCredential) {
//  userCredential.user.updateEmail('newyou@domain.com')
//})

class AddINf extends StatefulWidget {
  @override
  _AddINfState createState() => _AddINfState();
}

class _AddINfState extends State<AddINf> {
  final _fireStore = Firestore.instance;
  FirebaseUser loggedInUser;
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(user.email);
//        getData();
      }
    } catch (e) {
      print(e);
    }
  }

  void addData(BuildContext context) {
    if (int.parse(ageText) < 17) {
      final snackBar =
          SnackBar(content: Text('you can\'t go   with your age under 18'));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      _fireStore.collection('user').add(
        {
          'name': {
            'first': firstNameText,
            'mid': midNameText,
            'last': lastNameText,
          },
          'age': ageText,
          'email': emailText,
          'phone': phoneText,
          'gender': genderController.text,
          'url': url,
          'address': locationText,
        },
      );
      Navigator.pushNamed(context, '/home');
    }
//    final snackBar =
//    SnackBar(content: Text('Information add'));
//    Scaffold.of(context).showSnackBar(snackBar);
    // Navigator.pushNamed(context, '/home');
  }

  TextEditingController firstNameController;
  TextEditingController midNameController;
  TextEditingController lastNameController;
  TextEditingController ageController;
  TextEditingController emailController;
  TextEditingController phoneController;
  TextEditingController genderController;

  bool enable = false;
  File image;
  var image1;

  String url;
  String firstNameText;
  String midNameText;
  String lastNameText;
  String ageText = '0';
  String emailText;
  String phoneText;
  String genderText;
  String locationText = 'press button';

  @override
  void initState() {
    firstNameController = TextEditingController(text: firstNameText);
    midNameController = TextEditingController(text: midNameText);
    lastNameController = TextEditingController(text: lastNameText);
    ageController = TextEditingController(text: ageText);
    emailController = TextEditingController(text: emailText);
    phoneController = TextEditingController(text: phoneText);
    genderController = TextEditingController(text: genderText);

    getCurrentUser();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    midNameController.dispose();
    lastNameController.dispose();
    ageController.dispose();
    emailController.dispose();
    phoneController.dispose();
    genderController.dispose();
    super.dispose();
  }

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position currentPosition;
  Position getPosition;
  GeoPoint geoPoint;

  String currentAddress;

  //Map<String, dynamic> map1 = {'first': 'name', 'mid': 'name', 'last': 'name'};
  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            localization.translate("Add Information"),
            style: TextStyle(
              color: foregroundColor,
            ),
          ),
//          leading: IconButton(
//              icon: Icon(
//                Icons.arrow_back,
//                size: 30,
//                color: foregroundColor,
//              ),
//              onPressed: () {
//                Navigator.pushNamed(context, '/home');
//              }),
          actions: <Widget>[
            Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Builder(
                builder: (context) => FlatButton(
                  onPressed: () {
//                    _fireStore.collection('user').add(
//                      {
//                        'name': {
//                          'first': firstNameText,
//                          'mid': midNameText,
//                          'last': lastNameText,
//                        },
//                        'age': ageText,
//                        'email': emailText,
//                        'phone': phoneText,
//                        'gender': genderController.text,
//                        'url': url,
//                        'address': currentAddress,
//                      },
//                    );
//
//                    Navigator.pushNamed(context, '/home');
                    addData(context);
                  },
                  child: Text(
                    'Done',
                    style: TextStyle(fontSize: 22),
                  ),
                  color: Colors.white,
                  textColor: foregroundColor,
                  disabledColor: Colors.white,
                  disabledTextColor: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: CircleAvatar(
                    // backgroundImage: image1,
                    backgroundImage: image == null ? null : FileImage(image),
                    radius: 60,
                  ),
                ),
                Theme(
                  data: ThemeData(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: Builder(
                    builder: (context) => FlatButton(
                      onPressed: () {
                        uploadImage(context);
                      },
                      child: Text(
                        localization.translate("Change profile photo"),
                        style: TextStyle(color: foregroundColor),
                      ),
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(child: Divider(color: Colors.black)),
                ReusableEditUser(
                  controller: firstNameController,
                  hint: localization.translate("First Name"),
                  textFieldName: localization.translate("First Name"),
                  getText: (value) {
                    firstNameText = value;
                  },
                ),
                SizedBox(child: Divider(color: Colors.black)),
                ReusableEditUser(
                  controller: midNameController,
                  hint: localization.translate("Mid Name"),
                  textFieldName: localization.translate("Mid Name"),
                  getText: (value) {
                    midNameText = value;
                  },
                ),
                SizedBox(child: Divider(color: Colors.black)),
                ReusableEditUser(
                  controller: lastNameController,
                  hint: localization.translate("Last Name"),
                  textFieldName: localization.translate("Last Name"),
                  getText: (value) {
                    lastNameText = value;
                  },
                ),
                SizedBox(child: Divider(color: Colors.black)),
                ReusableEditUser(
                  controller: ageController,
                  hint: localization.translate("Age"),
                  textFieldName: localization.translate("Age"),
                  getText: (value) {
                    ageText = value;
                  },
                ),
                SizedBox(child: Divider(color: Colors.black)),
                ReusableEditUser(
                  controller: emailController,
                  hint: localization.translate("Email"),
                  textFieldName: localization.translate("Email"),
                  getText: (value) {
                    emailText = value;
                  },
                ),
                SizedBox(child: Divider(color: Colors.black)),
                ReusableEditUser(
                  controller: phoneController,
                  hint: localization.translate("phone"),
                  textFieldName: localization.translate("phone"),
                  getText: (value) {
                    phoneText = value;
                  },
                ),
                SizedBox(child: Divider(color: Colors.black)),
                ReusableEditUser(
                  controller: genderController,
                  hint: localization.translate("Gender"),
                  textFieldName: localization.translate("Gender"),
                  getText: (value) {
                    genderText = value;
                  },
                ),
                SizedBox(child: Divider(color: Colors.black)),
                Row(
                  children: <Widget>[
                    Text(
                      'address',
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
                        onPressed: getCurrentLocation())
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ///
//  void pickImage() async {
//    var imageUP = await ImagePicker.pickImage(source: ImageSource.gallery);
//    setState(() {
//      image = imageUP;
//    });
//  }

  void uploadImage(context) async {
    ///pick image from gallery
    var imageUP = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = imageUP;
    });

    ///upload image to storage
    try {
      StorageReference storageRef =
          FirebaseStorage.instance.ref().child('users');
      StorageReference ref = storageRef.child(basename(image.path));
      StorageUploadTask storageUploadTask = ref.putFile(image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));
      String getUrl = await taskSnapshot.ref.getDownloadURL();
      print(getUrl);
      print('url $getUrl');
      setState(() {
        url = getUrl;
      });
    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }

//  void loadImage(String url1) async {
//    var imageId = await ImageDownloader.downloadImage(url1);
//    var path = await ImageDownloader.findPath(imageId);
//    File image1 = File(path);
//    setState(() {
//      image = image1;
//    });
//
////    setState(() {
////      image1 = NetworkImage(url1);
////    });
//
////    ///
////    var imageId = await ImageDownloader.downloadImage(url1);
////    var path = await ImageDownloader.findPath(imageId);
////    File image1 = File(path);
////    setState(() {
////      image = image1;
////    });
//  }

//  void getData() async {
//    print('xxxxxxxxxxxxxxxxxxxxxx');
//    _fireStore
//        .collection('user')
//        .where("email", isEqualTo: loggedInUser.email)
//        .snapshots()
//        .listen((data) => data.documents.forEach((doc) {
//              setState(() {
//                url = doc['url'];
//                map1 = doc['name'];
//                firstNameText = map1['first'];
//                midNameText = map1['mid'];
//                lastNameText = map1['last'];
//                ageText = doc['age'];
//                emailText = doc['email'];
//                phoneText = doc['phone'];
//                //  locationText = doc['address'];
//                firstNameController.text = firstNameText;
//                midNameController.text = midNameText;
//                lastNameController.text = lastNameText;
//                ageController.text = ageText;
//                emailController.text = emailText;
//                phoneController.text = phoneText;
//                print(url);
//                print(map1['first']);
//                print(map1['mid']);
//                print(map1['last']);
//                print(ageText);
//                print(emailText);
//                print(phoneText);
//              });
//              loadImage(url);
//            }));
//    print('xxxxxxxxxxxxxxxxxxxxxx');
//  }

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
        locationText =
            place.name + " " + place.subLocality + " " + place.locality;
        TextEditingController(text: locationText);
        print(place.name + place.locality + place.postalCode + place.country);
      });
    } catch (e) {
      print(e);
    }
  }
}
