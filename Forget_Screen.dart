import 'package:customer_app/Intro_page.dart';
import 'package:customer_app/Login.dart';
import 'package:customer_app/Sign-up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'Forget.dart';

class Forget_Screen extends StatefulWidget {
  @override
  _Forget_ScreenState createState() => _Forget_ScreenState();
}

class _Forget_ScreenState extends State<Forget_Screen> {
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
                icon: Icon(Icons.lock),
                text: 'Forget Password',
              ),
            ]),
          ),
          body: TabBarView(children: <Widget>[
            Forget(),
          ]),
        ),
      ),
    );
  }
}
