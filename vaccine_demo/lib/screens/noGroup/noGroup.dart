import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_dart/actor.dart';
import 'package:vaccinedemo/screens/creategroup/creategroup.dart';
import 'package:vaccinedemo/screens/joingroup/joingroup.dart';

class OurnoGroupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _gotoJoin(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OurJoinGroup()),
      );
    }

    void _gotoCreate(BuildContext context) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OurCreateGroup()),
      );
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              width: 400.0,
              height: 300.0,
              child: new FlareActor(
                "assets/Book 2.flr",
                alignment: Alignment.centerRight,
                animation: "Untitled",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Text(
              "Welcome to Book Club",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: Colors.grey[600],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Since you are not in book club, you can select either " +
                  "to join a club or create a club ",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey[600],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                    child: Text("Create"),
                    onPressed: () => _gotoCreate(context),
                    color: Theme.of(context).canvasColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          color: Theme.of(context).secondaryHeaderColor,
                          width: 2),
                    )),
                RaisedButton(
                  child: Text(
                    "Join",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => _gotoJoin(context),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
