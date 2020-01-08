import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {

  //final String providerDetails;
  String userName;
  String photoUrl;
  String userEmail;
  String userID;
  //final DocumentReference reference;

  UserDetails.fromMap(Map<String, dynamic> map,)// {this.reference})
      : assert(map['userName'] != null),
        assert(map['photoUrl'] != null),
        assert(map['userEmail'] != null),
        assert(map['userID'] != null),
        userName = map['userName'],
        photoUrl = map['photoUrl'],
        userEmail = map['userEmail'],
        userID = map['userID'];



  UserDetails(this.userName, this.photoUrl, this.userEmail, this.userID);//,this.reference);

/*UserDetails.fromSnapShot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);*/

}