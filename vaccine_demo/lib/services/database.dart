import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vaccinedemo/models/Books.dart';
import 'package:vaccinedemo/models/Group.dart';
import 'package:vaccinedemo/models/user.dart';

class OurDatabase {
  final Firestore _firestore = Firestore.instance;
  Future<String> CreateUser(Ouruser user) async {
    String retVal = "error";
    try {
      await _firestore.collection("users").document(user.uid).setData({
        'fullname': user.fullname,
        'email': user.email,
        'accountCreated': Timestamp.now()
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<Ouruser> getUserinfo(String uid) async {
    Ouruser retVal = Ouruser();
    try {
      DocumentSnapshot _documentSnapshot =
          await _firestore.collection("users").document(uid).get();
      retVal.uid = uid;
      retVal.fullname = _documentSnapshot.data["fullname"];
      retVal.email = _documentSnapshot.data["email"];
      retVal.accountCreated = _documentSnapshot.data["accountCreated"];
      retVal.groupId = _documentSnapshot.data["groupId"];
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> CreateGroup(String groupname, String UserUid) async {
    String retVal = "error";
    List<String> members = List();
    try {
      members.add(UserUid);
      DocumentReference _docref = await _firestore.collection("groups").add({
        'name': groupname,
        'Leader': UserUid,
        'Members': members,
        'GroupCreated': Timestamp.now(),
      });

      await _firestore.collection("users").document(UserUid).updateData({
        'groupId': _docref.documentID,
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> JoinGroup(String groupId, String UserUid) async {
    String retVal = "error";
    List<String> members = List();
    try {
      members.add(UserUid);
      await _firestore.collection("groups").document(groupId).updateData({
        'members': FieldValue.arrayUnion(members),
      });
      await _firestore.collection("users").document(UserUid).updateData({
        'groupId': groupId,
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<OurGroup> getGroupinfo(String groupId) async {
    OurGroup retVal = OurGroup();
    try {
      DocumentSnapshot _documentSnapshot =
          await _firestore.collection("groups").document(groupId).get();
      retVal.id = groupId;
      retVal.name = _documentSnapshot.data["name"];
      retVal.leader = _documentSnapshot.data["leader"];
      retVal.members = List<String>.from(_documentSnapshot.data["members"]);
      retVal.groupcreated = _documentSnapshot.data["groupCreated"];
      retVal.currentBookId = _documentSnapshot.data["currentBookId"];
      retVal.currentBookDue = _documentSnapshot.data["currentBookDue"];
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<OurBook> getCurrentBook(String groupId, String bookId) async {
    OurBook retVal = OurBook();
    try {
      DocumentSnapshot _documentSnapshot = await _firestore
          .collection("groups")
          .document(groupId)
          .collection("books")
          .document(bookId)
          .get();
      retVal.id = bookId;
      retVal.name = _documentSnapshot.data["name"];
      retVal.length = _documentSnapshot.data["length"];
      retVal.DateCompleted = _documentSnapshot.data["dateCompleted"];
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
