import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vaccinedemo/models/user.dart';
import 'package:vaccinedemo/services/database.dart';

class CurrentUser extends ChangeNotifier {
  Ouruser _currentuser = Ouruser();
  Ouruser get getCurrentUser => _currentuser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";
    try {
      FirebaseUser _firebaseuser = await _auth.currentUser();
      _currentuser = await OurDatabase().getUserinfo(_firebaseuser.uid);
      if (_currentuser != null) {
        retVal = "success";
      }
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> SignOut() async {
    String retVal = "error";
    try {
      await _auth.signOut();
      _currentuser = Ouruser();

      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> signUpUser(
      String email, String password, String fullname) async {
    String retVal = "error";
    Ouruser _user = Ouruser();
    try {
      AuthResult _authresult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _authresult.user.uid;
      _user.email = _authresult.user.email;
      _user.fullname = fullname;
      String _returnString = await OurDatabase().CreateUser(_user);
      if (_returnString == "success") {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    }

    return retVal;
  }

  Future<String> LoginuserwithEmail(String email, String password) async {
    String retVal = "error";
    try {
      AuthResult _authresult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      _currentuser = await OurDatabase().getUserinfo(_authresult.user.uid);
      if (_currentuser != null) {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    }

    return retVal;
  }

  Future<String> LoginuserwithGoogle() async {
    String retVal = "error";
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    Ouruser _user = Ouruser();
    try {
      GoogleSignInAccount _googleuser = await _googleSignIn.signIn();

      GoogleSignInAuthentication _googleauth = await _googleuser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: _googleauth.idToken, accessToken: _googleauth.accessToken);
      AuthResult _authresult = await _auth.signInWithCredential(credential);
      if (_authresult.additionalUserInfo.isNewUser) {
        _user.uid = _authresult.user.uid;
        _user.email = _authresult.user.email;
        _user.fullname = _authresult.user.displayName;
        OurDatabase().CreateUser(_user);
      }
      _currentuser = await OurDatabase().getUserinfo(_authresult.user.uid);
      if (_currentuser != null) {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    }

    return retVal;
  }
}
