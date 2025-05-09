import 'package:customer_app/Intro_page.dart';
import 'package:customer_app/Login.dart';
import 'package:customer_app/Sign-up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class Authentication2_Screen extends StatefulWidget {
  @override
  _Authentication2_ScreenState createState() => _Authentication2_ScreenState();
}

class _Authentication2_ScreenState extends State<Authentication2_Screen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.black));

    return Container(
      color: Colors.white,
      child: DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.orange,
            title: Center(
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 40.0,
                child: Image.asset(
                  'assets/logo1.png',
                  width: 70,
                ),
              ),
            ),
            bottom: TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(Icons.verified_user),
                text: 'Log-In',
              ),
            ]),
          ),
          body: TabBarView(children: <Widget>[
            Login(),
          ]),
        ),
      ),
    );
  }
}
