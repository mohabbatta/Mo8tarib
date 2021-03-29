import 'package:geolocator/geolocator.dart';

class AddPropertyModel {
  final String typeValue;
  final String categoryValue;
  final String genderValue;
  final String description;
  final String size;
  final int price;
  final String address;
  final Position position;
  final DateTime startDate;
  final DateTime endDate;
  final List services;
  final List imagesUrl;
  final bool isLoading;

  AddPropertyModel({
    this.typeValue = 'Any',
    this.categoryValue = 'Any',
    this.genderValue = 'Any',
    this.description = 'description',
    this.size = '00',
    this.address = 'address',
    this.price = 100,
    this.startDate,
    this.endDate,
    this.position,
    this.services,
    this.imagesUrl,
    this.isLoading = false,
  });

  AddPropertyModel copyWith(
      {String typeValue,
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
      bool isLoading}) {
    return AddPropertyModel(
      typeValue: typeValue ?? this.typeValue,
      categoryValue: categoryValue ?? this.categoryValue,
      genderValue: genderValue ?? this.genderValue,
      description: description ?? this.description,
      size: size ?? this.size,
      price: price ?? this.price,
      address: address ?? this.address,
      position: position ?? this.position,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      services: services ?? this.services,
      imagesUrl: imagesUrl ?? this.imagesUrl,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  DateTime startDateTime() {
    return startDate ?? DateTime.now();
  }

  DateTime endDateTime() {
    return endDate ?? DateTime.now().add(new Duration(days: 7));
  }
}
