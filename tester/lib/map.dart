import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tester/values/borders.dart';
import 'package:tester/values/colors.dart';
import 'package:tester/values/radii.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapbox_search/mapbox_search.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';

import 'userinfo.dart';
import 'detail.dart';
import 'info.dart';

const kGoogleApiKey = "AIzaSyBsYyXBDCMLdKlyTgOkyN0bkhvNL76X0-Y";

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(45.521563, -122.677433);
  final Set<Marker> _allMarkers = {} ;
  double pinPillPosition = -100;
  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;
  BitmapDescriptor pinLocationIcon;
  bool flag = false;

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('info').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {

    if(flag == false) {
      return ListView(
        padding: const EdgeInsets.only(top: 60.0),
        children: snapshot.map((data) => _buildListItem(context, data))
            .toList(),
      );
    }

    else{
      return _openMap();
    }
  }

  Widget _openMap(){
    return Column(
      children: <Widget>[
        Container(
          width:MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 18,
          child: Row(
            children: <Widget> [
              Expanded(
                flex: 4,
                child: Text(
                  '   우리 주변 소식',
                  style: TextStyle(
                      fontSize: 16
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Text('모두 보기',
                      style: TextStyle(fontSize: 16),),
                    onTap: () {

                    },
                  )
              )
            ],
          ),
        ),
        Stack(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: GoogleMap(
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
                  Factory<OneSequenceGestureRecognizer>(
                          () => EagerGestureRecognizer())].toSet(),
                mapType: _currentMapType,
                myLocationEnabled: true,
                initialCameraPosition: _initialPosition,
                onMapCreated: _onMapCreated,
                markers: Set.from(_allMarkers),
                onTap: (LatLng location) {
                  setState(() {
                    pinPillPosition = -100;
                  });
                },
              ),
            ),
            AnimatedPositioned(
              bottom: pinPillPosition, right: 0, left: 0,
              duration: Duration(milliseconds: 100),
              child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: EdgeInsets.all(20),
                      height: 70,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                blurRadius: 20,
                                offset: Offset.zero,
                                color: Colors.grey.withOpacity(0.5)
                            )]
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(left: 10),
                                width: 50, height: 50,
                                child: ClipOval(
                                  child: Icon(Icons.pan_tool),
                                )
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text('',
                                    ),
                                    Text(
                                        '한솥도시락',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey
                                        )
                                    ),
                                  ], // end of Column Widgets
                                ),  // end of Column
                              ),
                            ),
                          ]
                      )
                  )
              ),
            ),
            Center(
              child:
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child:
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                    ),
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.notification_important, color: Colors.white,),
                        Text('방금 [한솥도시락]님의 [도시락 떨이_5000원]이 마감되었습니다',
                            style: TextStyle(color: Colors.white,)),
                      ],
                    )
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void initState(){
    super.initState();
    setCustomMapPin();

    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/image/star.png').then((onValue) {
      pinLocationIcon = onValue;
    });

    _allMarkers.add(Marker(
      markerId: MarkerId('myMarker'),
      draggable: true,
      icon: pinLocationIcon,
      onTap: () {
        setState(() {
          pinPillPosition = 0;
        });
      },
      position: LatLng(36.08162, 129.39893),
    ));
  }

  void setCustomMapPin() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5),
        'assets/destination_map_marker.png');
  }

  static final CameraPosition _initialPosition = CameraPosition(
    target: LatLng(36.08162, 129.39893),
    zoom: 16.0,
  );

  _onMapCreated(GoogleMapController controller){
    _controller.complete(controller);
  }

  Future<Position> getCurrentUserLocation() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((location) {
      return location;
    });
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final info = Info.fromSnapshot(data);

    _navigateDetail(BuildContext context) async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => DetailPage(info: info),
        ),
      );
    }

    return Padding(
      key: ValueKey(info.postingDate),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF151561)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: ListTile(
          title: Row(
            children: <Widget>[
              SizedBox(width: 10),
              Flexible(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text(info.title, style: TextStyle(fontSize: 25, fontFamily: 'pic'),),
                    ),
                    SizedBox(height: 10,),
                  ],
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(info.postingDate.toDate().toString(), style: TextStyle(fontFamily: 'pic'),),
                ],
              ),
            ],
          ),
          onTap: () => _navigateDetail(context),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text('양덕동'),
          leading: Icon(Icons.arrow_back),
          backgroundColor: AppColors.secondaryBackground,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.list),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
      ),
      body: Stack(
        children: <Widget> [
          _buildBody(context),
        ],
      ),
    );
  }
}


