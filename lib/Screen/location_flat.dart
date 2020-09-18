import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mo8tarib/global.dart';

class LocationFlat extends StatefulWidget {
  final String docId;

  const LocationFlat({Key key, this.docId}) : super(key: key);

  @override
  _LocationFlatState createState() => _LocationFlatState();
}

class _LocationFlatState extends State<LocationFlat> {
  GoogleMapController mapController;
  List<Marker> allMarkers = [];

  String searchAddr;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: Firestore.instance
            .collection('flat')
            .document(widget.docId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return new Text("Loading");
          }
          var flatDocument = snapshot.data;
          final arr = flatDocument['Location'];
          final locationCoords = LatLng(arr[0], arr[1]);
          //print(flatDocument['url']);
          allMarkers.add(Marker(
              markerId: MarkerId(flatDocument['price']),
              draggable: false,
              infoWindow: InfoWindow(
                  title: flatDocument['price'],
                  snippet: flatDocument['address']),
              position: locationCoords));

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  'location',
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
                    }),
              ),
              body: GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: locationCoords, zoom: 16.0),
                onMapCreated: onMapCreated,
                markers: Set.from(allMarkers),
              ));
        });
  }

  void onMapCreated(controller) {
    setState(() {
      mapController = controller;
    });
  }
}
