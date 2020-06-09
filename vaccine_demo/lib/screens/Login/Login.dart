import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccinedemo/screens/Login/LoginForm.dart';
import 'package:vaccinedemo/widgets/OurContainer.dart';

class OurLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Image.asset('assets/bookclub.png'),
                ),
                SizedBox(height: 40.0),
                OurLoginForm(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
