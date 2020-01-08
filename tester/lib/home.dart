import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';

import 'userinfo.dart';

const kGoogleApiKey = "AIzaSyBsYyXBDCMLdKlyTgOkyN0bkhvNL76X0-Y";

class HomePage extends StatefulWidget {
  UserDetails userDetails;

  HomePage({Key key, @required this.userDetails}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _allMarkers = {};
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  void initState(){
    super.initState();
    _allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      draggable: false,
      onTap: () {
        print('marker Tapped');
      },
      position: LatLng(36.10178845800692, 129.39088876577594),
    ));
  }

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(36.10178845800692, 129.39088876577594),
    zoom: 16.0,
  );

  /*static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);*/

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            child: GoogleMap(
              mapType: _currentMapType,
              myLocationEnabled: true,
              initialCameraPosition: _initialPosition,
              onMapCreated: _onMapCreated,
              markers: Set.from(_allMarkers),
            ),
          ),
          Positioned(
              top: 60,
              left: MediaQuery.of(context).size.width * 0.05,
              width: MediaQuery.of(context).size.width * 0.9,
              child: MapBoxPlaceSearchWidget(
                popOnSelect: true,
                apiKey:
                kGoogleApiKey,
                limit: 10,
                onSelected: (place) {},
                context: context,
              )
          ),
        ],
      ),
    );
  }

  Future<Position> getCurrentUserLocation() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((location) {
      return location;
    });
  }

}