import 'package:google_maps_flutter/google_maps_flutter.dart';

class Coffee {
  String price;
  String address;
  String description;
  String url;
  LatLng locationCoords;

  Coffee(
      {this.price,
      this.address,
      this.description,
      this.url,
      this.locationCoords});
}

final List<Coffee> coffeeShops = [];
