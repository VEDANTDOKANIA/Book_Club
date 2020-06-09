import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vaccinedemo/States/CurrentGroup.dart';
import 'package:vaccinedemo/States/CurrentUser.dart';
import 'package:provider/provider.dart';
import 'package:vaccinedemo/models/Group.dart';
import 'package:vaccinedemo/screens/noGroup/noGroup.dart';
import 'package:vaccinedemo/screens/root/root.dart';
import 'package:vaccinedemo/widgets/OurContainer.dart';
import 'package:vaccinedemo/services/database.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    CurrentUser _currentuser = Provider.of<CurrentUser>(context, listen: false);

    CurrentGroup _currentgroup =
        Provider.of<CurrentGroup>(context, listen: false);
    _currentgroup.UpdateStateFromDatabase(_currentuser.getCurrentUser.groupId);
  }

  void _gotoNoGroup(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => OurnoGroupScreen()));
  }

  void _signout(BuildContext context) async {
    CurrentUser _currentuser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentuser.SignOut();
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) => OurRoot()), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(child: Consumer<CurrentGroup>(
              builder: (BuildContext context, value, Widget child) {
                return Column(
                  children: <Widget>[
                    Text(
                      value.getCurrentBook.name ?? "loading...",
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey[600],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "Due in: ",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.grey[600],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              (value.getCurrentGroup.currentBookDue != null) ??
                                  value.getCurrentGroup.currentBookDue
                                      .toDate()
                                      .toString() ??
                                  "Loading....",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    RaisedButton(
                      child: Text(
                        "Finished Book",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {},
                    )
                  ],
                  // ignore: missing_return
                );
              },
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: OurContainer(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Next Book Revealed In: ",
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          "22 Hours",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            child: RaisedButton(
              child: Text(
                "Book Club History",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () => _gotoNoGroup(context),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: RaisedButton(
              child: Text("Sign out"),
              onPressed: () => _signout(context),
              color: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                    color: Theme.of(context).secondaryHeaderColor, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
