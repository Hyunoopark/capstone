import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';


void main() => runApp(MyApp());

const kGoogleApiKey = "AIzaSyBsYyXBDCMLdKlyTgOkyN0bkhvNL76X0-Y";

//GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
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

  /*Future<Null> displayPrediction(Prediction p) async {
    if (p != null) {
      PlacesDetailsResponse detail =
      await _places.getDetailsByPlaceId(p.placeId);

      var placeId = p.placeId;
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;

      var address = await Geocoder.local.findAddressesFromQuery(p.description);

      print(lat);
      print(lng);
    }
  }
   */


  /*Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }*/

  /*
  //검색하는 기능
  SearchMapPlaceWidget(
              apiKey: kGoogleApiKey,
              language: 'ko',
              location: _initialPosition.target,
              radius: 30000,
              onSelected: (place) async {
                final geolocation = await place.geolocation;

                final GoogleMapController controller = await _controller.future;

                controller.animateCamera(CameraUpdate.newLatLng(geolocation.coordinates));
                controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
              },
            ),
   */
}