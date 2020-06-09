import 'package:flutter/material.dart';
import 'package:vaccinedemo/screens/Home/Home.dart';
import 'package:vaccinedemo/screens/root/root.dart';
import 'package:vaccinedemo/widgets/OurContainer.dart';
import 'package:vaccinedemo/screens/Sign-up/Signup.dart';
import 'package:provider/provider.dart';
import 'package:vaccinedemo/States/CurrentUser.dart';

enum LoginType { email, google }

class OurLoginForm extends StatefulWidget {
  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();
  void _loginuser({
    @required LoginType type,
    String email,
    String password,
    BuildContext context,
  }) async {
    CurrentUser _currentuser = Provider.of<CurrentUser>(context, listen: false);
    try {
      String _returnString;
      switch (type) {
        case LoginType.email:
          _returnString =
              await _currentuser.LoginuserwithEmail(email, password);
          break;
        case LoginType.google:
          _returnString = await _currentuser.LoginuserwithGoogle();
          break;
      }

      if (_returnString == "success") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => OurRoot()),
            (route) => false);
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text(_returnString),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Widget _GoogleButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        _loginuser(type: LoginType.google, context: context);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.blueGrey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OurContainer(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8.0),
            child: Text(
              "Log-In",
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          TextFormField(
            controller: _emailcontroller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.alternate_email), hintText: "Email"),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordcontroller,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock_outline), hintText: "Password"),
            obscureText: true,
          ),
          SizedBox(height: 20),
          RaisedButton(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 100),
                child: Text(
                  "Log-In",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
              ),
              onPressed: () {
                _loginuser(
                    type: LoginType.email,
                    email: _emailcontroller.text,
                    password: _passwordcontroller.text,
                    context: context);
              }),
          FlatButton(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            child: Text("Don't have an account?Sign Up Here"),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(
                builder: (context) => OurSignUp(),
              ));
            },
          ),
          _GoogleButton(),
        ],
      ),
    );
  }
}
