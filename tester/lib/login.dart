import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home.dart';
import 'navigate.dart';
import 'userinfo.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  _navigateHome(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => NavigatePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:  Color(0xFF151561),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 120.0),
            Column(
              children: <Widget>[
                SizedBox(height: 16.0),
              ],
            ),
            SizedBox(height: 120.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10.0),
                Container(
                    width: 250.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: RaisedButton(
                        color: Color(0xffffffff),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(FontAwesomeIcons.google, color: Colors.yellow[700]),
                            SizedBox(width: 10.0,),
                            Text('카카오로 로그인하기',
                              style: TextStyle(color: Colors.black, fontSize: 18.0, fontFamily: 'pic'),),
                          ],
                        ),
                        onPressed: () async {
                          _navigateHome(context);
                        },
                      ),
                    )
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
