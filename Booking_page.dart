import 'package:flutter/material.dart';
import 'dart:async';

class Booking_Page extends StatefulWidget {
  @override
  _Booking_PageState createState() => _Booking_PageState();
}

class _Booking_PageState extends State<Booking_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(fit: StackFit.expand, children: <Widget>[
        Image.asset('assets/bokking.jpg', fit: BoxFit.cover),
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
          height: 150,
        ),
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 150),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.white70,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                "Contact Us",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.black,
                                    fontStyle: FontStyle.italic,
                                    fontFamily: "Times New Roman"),
                              ),
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 120),
                                  child: Text(
                                    "Office Address:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Times New Roman"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, left: 15, right: 5, bottom: 5),
                                  child: Text(
                                    "Abbas Khan Flat N0.4, Hasham Qtrs Shalimar Road Gulberg No.1, Peshawar Cantt",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: "Times New Roman"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 120),
                                  child: Text(
                                    "Ready To Book:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Times New Roman"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, right: 130),
                                  child: Text(
                                    "Call : 03159902035",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: "Times New Roman"),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5.0, left: 14),
                                  child: Text(
                                    "For all other inquiries, please call : 03485738285",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: "Times New Roman"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, left: 8, right: 5),
                                  child: Text(
                                    "Eat Street Call Center Hours:",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: "Times New Roman"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 50),
                                  child: Text(
                                    "Monday - Friday : 9am - 10pm",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: "Times New Roman"),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 50),
                                  child: Text(
                                    "Saturday - Sunday : 9am - 9pm",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: "Times New Roman"),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
