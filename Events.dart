import 'package:customer_app/Booking_page.dart';
import 'package:customer_app/tryagain.dart';
import 'package:customer_app/slideup.dart';
import 'package:customer_app/timer.dart';
import 'package:customer_app/try.dart';
import 'package:customer_app/tryyy.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';
import 'drawer.dart';

import 'Intro_page.dart';
import 'Order_Status.dart';

class Events extends StatefulWidget {
  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Events> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            _slider(),
          ],
        ),
      ),
    );
  }

  Widget _slider() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/cat3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        "Catering",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontFamily: "Times New Roman",
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        child: Center(
                          child: Text(
                            "        " +
                                "We make your events memorable with our flavours.",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Times New Roman",
                              // fontWeight: FontWeight.bold
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  child: Column(
                    children: <Widget>[
                      Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 1.0)),
                      Text(
                        'Events',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontFamily: "Times New Roman"),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            top: 2.0, left: 5.0, right: 5.0, bottom: 2.0),
                      ),
                      _data(),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget _data() {
    return Container(
      height: 465,
      child: PageView(
        pageSnapping: false,
        children: <Widget>[
          _event(),
        ],
      ),
    );
  }

  Widget _event() {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Event").snapshots(),
          builder: (context, snapshot) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 1.0,
                    mainAxisSpacing: 1.0),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot event = snapshot.data.documents[index];
                  return Container(
                    margin: EdgeInsets.only(left: 10.0, top: 10.0),
                    height: 50,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: Booking_Page()));
                          },
                          child: Container(
                            width: 340.0,
                            child: Card(
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: Wrap(
                                children: <Widget>[
                                  ClipRRect(
                                    child: Image.network(
                                      event.data()['Image'],
                                    ),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.0),
                                      topRight: Radius.circular(16.0),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Center(
                                    child: Text(
                                      event.data()['Name'],
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Times New Roman'),
                                    ),
                                  ),
                                  Container(
                                      padding: const EdgeInsets.only(
                                          left: 15.0,
                                          right: 15.0,
                                          bottom: 10.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              event.data()['Des'],
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontStyle: FontStyle.italic,
                                                  fontFamily:
                                                      'Times New Roman'),
                                            ),
                                          ])),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                });
          }),
    );
  }
}
