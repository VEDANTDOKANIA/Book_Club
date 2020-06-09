import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaccinedemo/States/CurrentGroup.dart';
import 'package:vaccinedemo/States/CurrentUser.dart';
import 'package:vaccinedemo/screens/Home/Home.dart';
import 'package:vaccinedemo/screens/Login/Login.dart';
import 'package:vaccinedemo/screens/noGroup/noGroup.dart';
import 'package:vaccinedemo/screens/splashscreen/Splashscreen.dart';

enum AuthStatus {
  unknown,
  NotLoggedIn,
  notIngroup,
  ingroup,
}

class OurRoot extends StatefulWidget {
  @override
  _OurRootState createState() => _OurRootState();
}

class _OurRootState extends State<OurRoot> {
  AuthStatus _authStatus = AuthStatus.unknown;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    CurrentUser _currentuser = Provider.of<CurrentUser>(context, listen: false);
    String _returnString = await _currentuser.onStartUp();
    if (_returnString == "success") {
      if (_currentuser.getCurrentUser.groupId != null) {
        setState(() {
          _authStatus = AuthStatus.ingroup;
        });
      } else {
        setState(() {
          _authStatus = AuthStatus.notIngroup;
        });
      }
    } else {
      setState(() {
        _authStatus = AuthStatus.NotLoggedIn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget retVal;

    switch (_authStatus) {
      case AuthStatus.unknown:
        retVal = OurSplashScreen();
        break;
      case AuthStatus.NotLoggedIn:
        retVal = OurLogin();
        break;
      case AuthStatus.ingroup:
        retVal = ChangeNotifierProxyProvider(
            create: (context) => CurrentGroup(), child: HomeScreen());
        break;
      case AuthStatus.notIngroup:
        retVal = OurnoGroupScreen();
        break;
      default:
    }
    return retVal;
  }
}
