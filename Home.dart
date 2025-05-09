import 'package:flutter/material.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Image.asset('assets/bb1.jpg', fit: BoxFit.cover),
        Container(
          margin: EdgeInsets.only(top: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/logo.png', width: 150),
            ],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 180, left: 15),
          child: Column(
            children: <Widget>[
              Text(
                "Pick your phone and "
                "enjoy your food",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 30.0,
                  fontFamily: "Times New Roman",
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Enjoy the taste of restaurant in your home.Just make an "
                "order and wait for the door bell to ring",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontFamily: "Times New Roman",
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
