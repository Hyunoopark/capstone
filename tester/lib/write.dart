import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import 'navigate.dart';

class WritingPage extends StatefulWidget {

  @override
  _WritingPageState createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Write',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('작성', style: TextStyle(fontFamily: 'sunflower'),),
          backgroundColor:  Color(0xFF151561),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(15, 8, 15, 8),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[

                    RaisedButton(
                      child: Text("쓰기 완료", style: TextStyle(fontFamily: 'pic'),),
                      onPressed: () {
                        Firestore.instance.collection('info').document().setData({
                          'title': '현우',
                          'user': '현',
                          'postingDate': FieldValue.serverTimestamp(),
                        });
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => NavigatePage()
                            )
                        );
                      },
                    )
              ],
            ),
          ],
          ),
        ),
      ),
    )
    );
  }
}