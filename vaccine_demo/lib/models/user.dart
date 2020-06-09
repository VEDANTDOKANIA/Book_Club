import 'package:cloud_firestore/cloud_firestore.dart';

class Ouruser {
  String uid;
  String email;
  String fullname;
  Timestamp accountCreated;
  String groupId;

  Ouruser({
    this.uid,
    this.email,
    this.fullname,
    this.accountCreated,
    this.groupId,
  });
}
