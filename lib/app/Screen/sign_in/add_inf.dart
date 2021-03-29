import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mo8tarib/app/Screen/dashboard/dashboard_layout.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/app/common_widgets/resuable_edit_user.dart';
import 'package:mo8tarib/constants/global.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:provider/provider.dart';

class AddINf extends StatefulWidget {

  static Widget create(BuildContext context, MyUser user) {
    return Provider<MyUser>.value(
      value: user,
      child: Provider<Database>(
        create: (_) => FireStoreDatabase(uid: user.uid),
        child: AddINf(),
      ),
    );
  }

  @override
  _AddINfState createState() => _AddINfState();
}

class _AddINfState extends State<AddINf> {
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

  Future<void> _saveUser(BuildContext context) async {
    final user = Provider.of<MyUser>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);

    final id = user?.uid;
    final newUser = MyUser(
      uid: id,
      disPlayName: " ${firstNameController.text} ${lastNameController.text} ",
      email: user.email,
      photoUrl: url,
      age: ageController.text,
      gender: genderController.text,
      phone: phoneController.text,
      address: locationText,
    );
    await database.setUser(newUser);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Provider<Database>(
            create: (_) => FireStoreDatabase(uid: user.uid),
            child: DashBoardLayout(
              uid: user.uid,
            )),
      ),
    );

  }

  Future<bool> _onBackPressed(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Are you sure?'),
            content: new Text('please Complete your data'),
            actions: <Widget>[
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text("no"),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        _onBackPressed(context);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              "Add Information",
              style: TextStyle(
                color: foregroundColor,
              ),
            ),
            actions: <Widget>[
              Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: FlatButton(
                  child: Text('done'),
                  onPressed: () async {
                    await _saveUser(context);
                  },
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
                          "Change profile photo",
                          style: TextStyle(color: foregroundColor),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(child: Divider(color: Colors.black)),
                  ReusableEditUser(
                    controller: firstNameController,
                    hint: "First Name",
                    textFieldName: "First Name",
                    getText: (value) {
                      firstNameText = value;
                    },
                  ),
                  SizedBox(child: Divider(color: Colors.black)),
//                  ReusableEditUser(
//                    controller: midNameController,
//                    hint: "Mid Name",
//                    textFieldName: "Mid Name",
//                    getText: (value) {
//                      midNameText = value;
//                    },
//                  ),
//                  SizedBox(child: Divider(color: Colors.black)),
                  ReusableEditUser(
                    controller: lastNameController,
                    hint: "Last Name",
                    textFieldName: "Last Name",
                    getText: (value) {
                      lastNameText = value;
                    },
                  ),
                  SizedBox(child: Divider(color: Colors.black)),
                  ReusableEditUser(
                    controller: ageController,
                    hint: "Age",
                    textFieldName: "Age",
                    getText: (value) {
                      ageText = value;
                    },
                  ),
                  SizedBox(child: Divider(color: Colors.black)),
//                  ReusableEditUser(
//                    controller: emailController,
//                    hint: "Email",
//                    textFieldName: user.email,
//                    getText: (value) {
//                      emailText = value;
//                    },
//                  ),
//                  SizedBox(child: Divider(color: Colors.black)),
                  ReusableEditUser(
                    controller: phoneController,
                    hint: "phone",
                    textFieldName: "phone",
                    getText: (value) {
                      phoneText = value;
                    },
                  ),
                  SizedBox(child: Divider(color: Colors.black)),
                  ReusableEditUser(
                    controller: genderController,
                    hint: "Gender",
                    textFieldName: "Gender",
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
                          onPressed: () {
                            //getCurrentLocation();
                          })
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
///TODO update Storage
  void uploadImage(context) async {
    ///pick image from gallery
    // var imageUP = await ImagePicker.pickImage(source: ImageSource.gallery);
    // setState(() {
    //   image = imageUP;
    // });
    //
    // ///upload image to storage
    // try {
    //   StorageReference storageRef =
    //       FirebaseStorage.instance.ref().child('users');
    //   StorageReference ref = storageRef.child(basename(image.path));
    //   StorageUploadTask storageUploadTask = ref.putFile(image);
    //   StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;
    //   Scaffold.of(context).showSnackBar(SnackBar(
    //     content: Text('success'),
    //   ));
    //   String getUrl = await taskSnapshot.ref.getDownloadURL();
    //   print(getUrl);
    //   print('url $getUrl');
    //   setState(() {
    //     url = getUrl;
    //   });
    //   print(url);
    // } catch (ex) {
    //   Scaffold.of(context).showSnackBar(SnackBar(
    //     content: Text(ex.message),
    //   ));
    // }
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

//  getCurrentLocation() {
//    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
//
//    geolocator
//        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
//        .then((Position position) {
//      print(position);
//      setState(() {
//        currentPosition = position;
//      });
//      _getAddressFromLatLng();
//    }).catchError((e) {
//      print(e);
//    });
//  }
//
//  _getAddressFromLatLng() async {
//    try {
//      List<Placemark> p = await geolocator.placemarkFromCoordinates(
//          currentPosition.latitude, currentPosition.longitude);
//      Placemark place = p[0];
//      setState(() {
//        locationText =
//            place.name + " " + place.subLocality + " " + place.locality;
//        TextEditingController(text: locationText);
//        print(place.name + place.locality + place.postalCode + place.country);
//      });
//    } catch (e) {
//      print(e);
//    }
//  }
}
