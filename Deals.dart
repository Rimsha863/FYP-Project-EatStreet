import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:page_transition/page_transition.dart';

import 'deals_detail.dart';

class Deals extends StatefulWidget {
  @override
  _DealsState createState() => _DealsState();
}

class _DealsState extends State<Deals> {
  // Future getimgfromFirebase() async {
  //   // ignore: deprecated_member_use
  //   var firestore = Firestore.instance;
  //   // ignore: deprecated_member_use
  //   QuerySnapshot qn = await firestore.collection("Deals").getDocuments();
  //   // ignore: deprecated_member_use
  //   return qn.documents;
  // }

  bool _isPlaying = true;
  GlobalKey<CarouselSliderState> _sliderKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("Deals").snapshots(),
                builder: (context, snapshot) {
                  return CarouselSlider.builder(
                    key: _sliderKey,
                    unlimitedMode: true,
                    slideBuilder: (index) {
                      DocumentSnapshot sliderimage =
                          snapshot.data.documents[index];
                      return Container(
                        child: Image.network(sliderimage.data()['Image']),
                      );
                    },
                    slideTransform: CubeTransform(),
                    slideIndicator: CircularSlideIndicator(
                        indicatorBackgroundColor: Colors.yellow,
                        currentIndicatorColor: Colors.orange),
                    itemCount: snapshot.data.documents.length,
                  );
                }),
          ),
          _data(),
        ],
      ),
    );
  }

  Widget _data() {
    return Container(
      height: 400,
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
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Deals").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot deal = snapshot.data.documents[index];

                return deal.data()['Active'] != 'Active'
                    ? Container(
                        margin: EdgeInsets.only(left: 10.0, top: 10.0),
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              child: Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Wrap(
                                  children: <Widget>[
                                    ClipRRect(
                                      child: Image.network(
                                        deal.data()['Image'],
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
                                        deal.data()['Name'],
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Times New Roman'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        deal.data()['Price'] + " " " Rs.",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'Times New Roman'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Text(
                                      "Not Available",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Times New Roman',
                                          color: Colors.red),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(left: 10.0, top: 10.0),
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                print(
                                  deal.data()['Price'],
                                );
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => deals_detail(
                                          imagee: deal.data()['Image'],
                                          namee: deal.data()['Name'],
                                          pricee: deal.data()['Price'],
                                          detaill: deal.data()['Detail'],
                                        )));
                              },
                              child: Container(
                                width: 150.0,
                                child: Card(
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Wrap(
                                    children: <Widget>[
                                      ClipRRect(
                                        child: Image.network(
                                          deal.data()['Image'],
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
                                          deal.data()['Name'],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Times New Roman'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          deal.data()['Price'] + " " "Rs ",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Times New Roman'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Available",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Times New Roman',
                                              color: Colors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
              }
              //}
              );
        },
      ),
    );
  }
}
