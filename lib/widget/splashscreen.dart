import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../main.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return Timer(Duration(seconds: 3), onDoneLoading);
  }

  onDoneLoading() async {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MyHomePage(title: 'Personal Expenses')));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets\\image\\splash.jpg'), fit: BoxFit.fill),
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 75),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "Welcome !",
              style: GoogleFonts.permanentMarker().apply(
                color: Colors.white, //Theme.of(context).appBarTheme.color,
                decoration: TextDecoration.none,
              ),
            ),
            CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
              Colors.white,
            ) //Theme.of(context).appBarTheme.color),
                ),
          ],
        ),
      ),
    );
  }
}
