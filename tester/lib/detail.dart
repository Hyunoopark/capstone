import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'info.dart';

class DetailPage extends StatefulWidget {
  Info info;
  DetailPage({Key key, @required this.info}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final GlobalKey<RefreshIndicatorState> _refreshkey = GlobalKey<
      RefreshIndicatorState>();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Layout Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF151561),
      ),
      home: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.info.title, style: TextStyle(fontFamily: 'sunflower'),),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.create),
                onPressed: () {

                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // 삭제할 건지 한번 물어봐주기 기능 추가하기
                  delete(widget.info);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: Text(widget.info.user),
      ),
    );
  }

  void delete(Info info) {
    Firestore.instance.collection('data').document(
        info.reference.documentID).delete();
  }

/*_navigateEditPage(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => EditPage(diary: widget.diary),
      ),
    );
  }*/
}