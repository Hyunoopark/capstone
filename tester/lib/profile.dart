import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userinfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  UserDetails userDetails;

  ProfilePage({Key key, @required this.userDetails}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Widget userProfilePhoto()
  {
    return Center(
        child: Container(
          height: 150.0,
          width: 150.0,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: Color.fromRGBO(245, 223, 76, 1),
                  width: 6.0,
                  style: BorderStyle.solid
              ),
              image: DecorationImage(
                fit : BoxFit.fill,
                image: NetworkImage(widget.userDetails.photoUrl),
              )
          ),
        )
    );
  }

  Widget build(BuildContext context){
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text('my page', style: TextStyle(fontFamily: 'sunflower'),),
        automaticallyImplyLeading: false,
      ),
      body: Center(

      ),
    );
  }
}

