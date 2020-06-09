import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class OurSplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                width: 400.0,
                height: 500.0,
                child: new FlareActor(
                  "assets/Minion.flr",
                  alignment: Alignment.centerRight,
                  animation: "Stand",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text("Loading!!!")
          ],
        ),
      ),
    );
  }
}
