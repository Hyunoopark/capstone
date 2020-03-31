import 'package:cloud_firestore/cloud_firestore.dart';

class Info {
  String title;
  String user;
  final Timestamp postingDate;
  final DocumentReference reference;


  Info.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['title'] != null),
        assert(map['user'] != null),
        title = map['title'],
        user = map['user'],
        postingDate = map['postingDate'];


  Info.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}