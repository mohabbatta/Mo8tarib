import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mo8tarib/app/Screen/property/add_propert_model.dart';
import 'package:mo8tarib/app/Screen/property/property_model.dart';
import 'package:mo8tarib/app/Screen/property/service.dart';
import 'package:mo8tarib/app/Screen/sign_in/model/user.dart';
import 'package:mo8tarib/services/data_base.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;
import 'package:provider/provider.dart';

class AddPropertyBloc {
  final StreamController<AddPropertyModel> _modelController =
      StreamController<AddPropertyModel>();
  Stream<AddPropertyModel> get modelStream => _modelController.stream;
  AddPropertyModel _model = AddPropertyModel();

  void dispose() {
    _modelController.close();
  }

  void updateWith({
    String typeValue,
    String categoryValue,
    String genderValue,
    String description,
    String size,
    int price,
    String address,
    Position position,
    DateTime startDate,
    DateTime endDate,
    List services,
    List imagesUrl,
    bool isLoading,
  }) {
    _model = _model.copyWith(
      typeValue: typeValue,
      categoryValue: categoryValue,
      genderValue: genderValue,
      description: description,
      size: size,
      price: price,
      address: address,
      position: position,
      startDate: startDate,
      endDate: endDate,
      services: services,
      imagesUrl: imagesUrl,
      isLoading: isLoading,
    );
    _modelController.add(_model);
  }

  void updateTypeValue(String typeValue) => updateWith(typeValue: typeValue);
  void updateCategoryValue(String categoryValue) =>
      updateWith(categoryValue: categoryValue);
  void updateGenderValue(String genderValue) =>
      updateWith(genderValue: genderValue);
  void updateDescription(String description) =>
      updateWith(description: description);
  void updateSize(String size) => updateWith(size: size);
  void updatePrice(double price) => updateWith(price: price.round());
  void updateAddress(String address) => updateWith(address: address);

  void updateSelectedList(List value) {
    updateWith(services: value);
  }

  dynamic removeFromSelectedList(dynamic value) {
    _model.services.remove(value);
    updateWith(services: _model.services);
  }

  void updateImageList(List imagesUrl) {
    updateWith(imagesUrl: imagesUrl);
  }

  final items = Service.services
      .map((service) => MultiSelectItem<Service>(service, service.name))
      .toList();

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  ///
  getCurrentLocation() async {
    await geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
      updateWith(position: position);
      print(position);
      try {
        List<Placemark> p = await geolocator.placemarkFromCoordinates(
            position.latitude, position.longitude);

        Placemark place = p[0];
        final address = place.name +
            " " +
            place.subAdministrativeArea +
            " " +
            place.administrativeArea;
        updateWith(address: address);
        print(_model.address);
        return address;
      } catch (e) {
        print(e);
      }
    }).catchError((e) {
      print(e);
    });
  }

  ///
  Future displayDateRange(BuildContext context) async {
    final List<DateTime> picked = await DateRagePicker.showDatePicker(
      context: context,
      initialFirstDate: _model.startDateTime(),
      initialLastDate: _model.endDateTime(),
      firstDate: new DateTime(DateTime.now().year - 5),
      lastDate: new DateTime(DateTime.now().year + 5),
    );
    if (picked != null && picked.length == 2) {
      print(picked);
      updateWith(startDate: picked[0], endDate: picked[1]);
    }
  }

  ///
  List<String> urls = <String>[];
  Map<String, String> _paths;
  String _extension;

  void openFileExplorer() async {
    updateWith(isLoading: true);
    try {
      _paths = await FilePicker.getMultiFilePath(type: FileType.image);
      uploadToFirebase();
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
  }

  uploadToFirebase() {
    _paths.forEach((fileName, filePath) => {upload(fileName, filePath)});
    updateWith(isLoading: false);
  }
///TODO update storage
  upload(fileName, filePath) async {
    // _extension = fileName.toString().split('.').last;
    // StorageReference storageRef =
    //     FirebaseStorage.instance.ref().child(fileName);
    // final StorageUploadTask uploadTask = storageRef.putFile(
    //   File(filePath),
    //   StorageMetadata(
    //     contentType: '$FileType.image/$_extension',
    //   ),
    // );
    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // String getUrl = await taskSnapshot.ref.getDownloadURL();
    // urls.add(getUrl);
    // updateImageList(urls);
  }

  String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

  Future<void> addProperty(BuildContext context, AddPropertyModel model) async {
    final user = Provider.of<MyUser>(context, listen: false);
    final database = Provider.of<Database>(context, listen: false);
    final id = user?.uid;
    final pid = documentIdFromCurrentDate();
    final newProperty = Property(
      pid: pid,
      uid: id,
      type: model.typeValue,
      category: model.categoryValue,
      gender: model.genderValue,
      description: model.description,
      size: model.size,
      price: model.price,
      address: model.address,
      position: GeoPoint(model.position.latitude, model.position.longitude),
      startDate: model.startDate.toIso8601String(),
      endDate: model.endDate.toIso8601String(),
      services: model.services,
      imageUrls: model.imagesUrl,
    );
    try {
      await database.setProperty(newProperty);
      final snackBar =
          SnackBar(content: Text('property added  to pending property'));
      Scaffold.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e.toString());
      final snackBar = SnackBar(content: Text(e.toString()));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}
