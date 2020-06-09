import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vaccinedemo/screens/Login/LoginForm.dart';
import 'package:vaccinedemo/screens/root/root.dart';
import 'screens/Login/Login.dart';
import 'utlis/OurTheme.dart';
import 'States/CurrentUser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CurrentUser(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: OurTheme().buildTheme(),
        home: OurRoot(),
      ),
    );
  }
}
