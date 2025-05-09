import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/BottomNavBar.dart';
import 'package:customer_app/Login.dart';
import 'package:customer_app/authentication.dart';
import 'package:customer_app/chatroom.dart';
//import 'package:customer_app/chatroomtry.dart';
import 'package:customer_app/model/slide.dart';
import 'package:customer_app/model/slide2.dart';
import 'package:customer_app/widgets/slide_dots.dart';
import 'package:customer_app/widgets/slide_item.dart';
import 'package:customer_app/widgets2/slide-dots2.dart';
import 'package:customer_app/widgets2/slide_items2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rate_my_app/rate_my_app.dart';
//import 'package:getwidget/getwidget.dart';
import 'package:getflutter/components/rating/gf_rating.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'Animations/FadeAnimation.dart';
import 'ct.dart';
import 'models/CartModel.dart';

class OrderStatus extends StatefulWidget {
  @override
  _OrderStatusState createState() => _OrderStatusState();
}

class _OrderStatusState extends State<OrderStatus> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  CartModel cartModel = new CartModel();
  TextEditingController searchTextEditingController =
      new TextEditingController();
  bool isLoading = true;
  QuerySnapshot namee;
  String userName;
  String userOrderNumber;

  @override
  void initState() {
    getUserData();
    super.initState();
    Timer.periodic(Duration(minutes: 1), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
        if (_currentPage == 3) {
          setState(() {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: Feedback()));
          });
        }
      }
      //  else {
      //   _currentPage = 0;
      // }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  // final _firestore = FirebaseFirestore.instance;
  // GlobalKey<FormState> formkey = GlobalKey<FormState>();
  // final _controller = TextEditingController();
  // _sendMessageArea() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 8),
  //     height: 70,
  //     color: Colors.white,
  //     child: Row(
  //       children: [
  //         IconButton(
  //             icon: Icon(Icons.photo),
  //             iconSize: 25,
  //             color: Colors.orange,
  //             onPressed: () {}),
  //         Expanded(
  //           child: TextField(
  //             controller: _controller,
  //             decoration: InputDecoration.collapsed(
  //               hintText: 'Send a message...',
  //             ),
  //             textCapitalization: TextCapitalization.sentences,
  //           ),
  //         ),
  //         IconButton(
  //             icon: Icon(Icons.send),
  //             iconSize: 25,
  //             color: Colors.orange,
  //             onPressed: () {
  //               _firestore.collection('Messages').doc().set(
  //                 {
  //                   "Customer message": _controller.text,
  //                 },
  //               ).whenComplete(() => _controller.clear());
  //             }),
  //       ],
  //     ),
  //   );
  // }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection('CartData')
        .where('Email', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .get()
        .then((value) {
      print(value.docs.first.data()['Name']);
      print(value.docs.first.data()['order number']);
      userName = value.docs.first.data()['Name'];
      userOrderNumber = value.docs.first.data()['order number'];
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Image.asset('assets/logo.png', width: 150),

              SizedBox(
                height: 20,
              ),
              Text("your order number : "),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(top: 1),
                width: 550,
                height: 100,
                padding: EdgeInsets.all(1),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    border: Border.all(color: Colors.black38)),
                child: GestureDetector(
                  onTap: () {
                    print("hello nayyab");
                    // _chat();
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ChatRoom()));
                    //_chat();
                  },
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset('assets/Take.png',
                              width: 80, height: 90, fit: BoxFit.cover),
                          Column(
                            children: [
                              Text(
                                "Contact your rider",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Times New Rouman",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Ask for contactless delivery",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontFamily: "Times New Rouman",
                                ),
                              ),
                            ],
                          ),
                          Image.asset('assets/msg2.jpg',
                              width: 50, height: 50, fit: BoxFit.cover),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList2.length,
                      itemBuilder: (ctx, i) => SlideItem2(i),
                    ),
                    // Stack(
                    //   alignment: AlignmentDirectional.topStart,
                    //   children: <Widget>[
                    //     Container(
                    //       margin: const EdgeInsets.only(bottom: 35),
                    //       child: Row(
                    //         mainAxisSize: MainAxisSize.min,
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         children: <Widget>[
                    //           for (int i = 0; i < slideList.length; i++)
                    //             if (i == _currentPage)
                    //               SlideDots2(true)
                    //             else
                    //               SlideDots2(false)
                    //         ],
                    //       ),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
              // Divider(),
              // Container(
              //     margin: const EdgeInsets.only(top: 5),
              //     width: 550,
              //     height: 80,
              //     padding: EdgeInsets.all(10),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(10),
              //         color: Colors.white,
              //         border: Border.all(color: Colors.black38)),
              //     child: Padding(
              //       padding:
              //           const EdgeInsets.only(top: 10, left: 10, right: 10),
              //       child: Column(
              //         children: [
              //           Row(
              //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //             children: [
              //               Image.asset('assets/Take.png',
              //                   width: 50, height: 50, fit: BoxFit.cover),
              //               Column(
              //                 children: [
              //                   Text(
              //                     "Contact your rider",
              //                     style: TextStyle(
              //                       fontSize: 15,
              //                       fontFamily: "Times New Rouman",
              //                       fontWeight: FontWeight.bold,
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: 5,
              //                   ),
              //                   Text(
              //                     "Ask for contactless delivery",
              //                     style: TextStyle(
              //                       fontSize: 10,
              //                       fontFamily: "Times New Rouman",
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //               Image.asset('assets/msg2.jpg',
              //                   width: 50, height: 50, fit: BoxFit.cover),
              //             ],
              //           ),
              //         ],
              //       ),
              //     )),
              // Container(
              //   Stream
              // ),

              // SizedBox(
              //   height: 20,
              // ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: <Widget>[
              //     FlatButton(
              //       child: Text(
              //         'Feed-Back',
              //         style: TextStyle(
              //             fontSize: 18,
              //             fontStyle: FontStyle.italic,
              //             fontFamily: "Times New Roman"),
              //       ),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(5),
              //       ),
              //       padding: const EdgeInsets.all(15),
              //       color: Colors.orange,
              //       textColor: Colors.white,
              //       onPressed: () {
              //         Navigator.push(
              //             context,
              //             PageTransition(
              //                 type: PageTransitionType.fade,
              //                 child: Feedback()));
              //       },
              //     ),
              //     // Row(
              //     //   mainAxisAlignment: MainAxisAlignment.center,
              //     //   children: <Widget>[
              //     //     Text(
              //     //       'Have an account?',
              //     //       style: TextStyle(
              //     //           fontSize: 18,
              //     //           fontStyle: FontStyle.italic,
              //     //           fontFamily: "Times New Roman"),
              //     //     ),
              //     //     FlatButton(
              //     //       child: Text(
              //     //         'Login',
              //     //         style: TextStyle(
              //     //             fontSize: 18,
              //     //             fontStyle: FontStyle.italic,
              //     //             fontFamily: "Times New Roman"),
              //     //       ),
              //     //       onPressed: () {
              //     //         Navigator.push(
              //     //             context,
              //     //             PageTransition(
              //     //                 type: PageTransitionType.fade,
              //     //                 child: Authentication_Screen()));
              //     //       },
              //     //     ),
              //     //   ],
              //     // ),
              //   ],
              // )

              _detail(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _detail() {
    return Container(
      child: Text("heloooooooo"),
    );
  }

  // Widget _chat() {
  //   return Scaffold(
  //     backgroundColor: Color(0xFFF6F6F6),
  //     appBar: AppBar(
  //       elevation: 10,
  //       backgroundColor: Colors.orange,
  //       title: Center(
  //         child: Text(
  //           "Contact your rider  ",
  //           style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 20,
  //               fontWeight: FontWeight.bold,
  //               fontStyle: FontStyle.italic,
  //               fontFamily: "Times New Roman"),
  //         ),
  //       ),
  //       automaticallyImplyLeading: true,
  //       leading: IconButton(
  //         icon: Icon(Icons.arrow_back, color: Colors.white),
  //         onPressed: () {
  //           Navigator.of(context).pop();
  //         },
  //       ),
  //       actions: <Widget>[
  //         Container(
  //           margin: EdgeInsets.only(top: 5, right: 20),
  //           child: Image.asset('assets/msg2.jpg',
  //               width: 50, height: 50, fit: BoxFit.cover),
  //         )
  //       ],
  //     ),
  //     body: Column(
  //       children: [
  //         Expanded(
  //           child: Column(
  //             children: [
  //               Container(
  //                 child: Text("data"),
  //               ),
  //               Container(
  //                 child: Text("data"),
  //               ),
  //               Container(
  //                 child: Text("data"),
  //               ),
  //             ],
  //           ),
  //         ),
  //         _sendMessageArea(),
  //       ],
  //     ),
  //   );
  // }
}

class Feedback extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  String userName;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Customer')
        .where('Email', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .get()
        .then((value) {
      print(value.docs.first.data()['Name']);
      userName = value.docs.first.data()['Name'];
    });
    setState(() {
      // isLoading = false;
    });
  }

  final _firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  double _rating = 0.0;
  double _rating1 = 0.0;
  double _rating2 = 0.0;
  double _rating3 = 0.0;
  double _rating4 = 0.0;

  double count = 1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Feed-Back'),
              backgroundColor: Colors.orange,
            ),
            backgroundColor: Colors.white,
            body: Container(
              child: SingleChildScrollView(
                  child: Column(children: [
                SingleChildScrollView(
                    child: Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: FadeAnimation(
                            1.5,
                            Container(
                                margin: const EdgeInsets.only(top: 5),
                                width: 550,
                                height: 180,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Thanks for sharing your experience with Eat Street",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "Times New Rouman",
                                            fontStyle: FontStyle.italic),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      SmoothStarRating(
                                        starCount: 5,
                                        isReadOnly: false,
                                        spacing: 3,
                                        rating: _rating,
                                        size: 45,
                                        color: Colors.orange,
                                        borderColor: Colors.orange,
                                        allowHalfRating: false,
                                        onRated: (value) {
                                          setState(() {
                                            _rating = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ))))),
                Divider(
                  thickness: 5,
                ),
                SingleChildScrollView(
                    child: Padding(
                        padding:
                            const EdgeInsets.only(top: 12, left: 15, right: 15),
                        child: FadeAnimation(
                            1.5,
                            Column(children: [
                              Text(
                                "How would you rate the following?",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Times New Rouman",
                                    fontStyle: FontStyle.italic),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: 550,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Food",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Times New Rouman",
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SmoothStarRating(
                                              starCount: 5,
                                              isReadOnly: false,
                                              spacing: 2,
                                              rating: _rating,
                                              size: 20,
                                              color: Colors.orange,
                                              borderColor: Colors.orange,
                                              allowHalfRating: false,
                                              onRated: (value) {
                                                setState(() {
                                                  _rating1 = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: 550,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 8, right: 8),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Packaging",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Times New Rouman",
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SmoothStarRating(
                                              starCount: 5,
                                              isReadOnly: false,
                                              spacing: 2,
                                              rating: _rating,
                                              size: 20,
                                              color: Colors.orange,
                                              borderColor: Colors.orange,
                                              allowHalfRating: false,
                                              onRated: (value) {
                                                setState(() {
                                                  _rating2 = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: 550,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Rider",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Times New Rouman",
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SmoothStarRating(
                                              starCount: 5,
                                              isReadOnly: false,
                                              spacing: 2,
                                              rating: _rating,
                                              size: 20,
                                              color: Colors.orange,
                                              borderColor: Colors.orange,
                                              allowHalfRating: false,
                                              onRated: (value) {
                                                setState(() {
                                                  _rating3 = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  width: 550,
                                  height: 80,
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border:
                                          Border.all(color: Colors.black38)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 10, right: 10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              "Timelines",
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Times New Rouman",
                                              ),
                                            ),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            SmoothStarRating(
                                              starCount: 5,
                                              isReadOnly: false,
                                              spacing: 2,
                                              rating: _rating,
                                              size: 20,
                                              color: Colors.orange,
                                              borderColor: Colors.orange,
                                              allowHalfRating: false,
                                              onRated: (value) {
                                                setState(() {
                                                  _rating4 = value;
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                height: 20,
                              ),
                            ])))),
                Divider(
                  thickness: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Text(
                        "Anything else to add?",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Times New Rouman",
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          hintText: "What would you like other users to know ?",
                        ),
                      )
                    ],
                  ),
                ),
                FlatButton(
                    child: Text(
                      'Submit',
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Times New Roman"),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.all(15),
                    color: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () {
                      if (_rating != 0) {
                        _firestore.collection('Review').doc(userName).set(
                          {
                            "ReviewerName": userName,
                            "Thanks for sharing your experience with Eat Street":
                                _rating,
                            "food": _rating1,
                            "Packaging": _rating2,
                            "Rider": _rating3,
                            "Timeliness": _rating4,
                            "Comments": _controller.text,
                          },
                        );
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              title: Text(
                                "Thanks !!",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: "Times New Roman",
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              content: Text(
                                "Thank you for your responce",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontFamily: "Times New Roman"),
                              ),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(BottomNavBar.routeName);
                                    // Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Ok",
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                title: Text(
                                  "Confirmation",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontFamily: "Times New Roman",
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                                content: Text(
                                  "Do You Want to give Review?",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: "Times New Roman"),
                                ),
                                actions: [
                                  FlatButton(
                                    onPressed: () async {
                                      Navigator.pop(context);
                                    },
                                    child: Text("Yes"),
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(BottomNavBar.routeName);
                                    },
                                    child: Text("No"),
                                  ),
                                ],
                              );
                            });
                      }
                    }),
              ])),
            )));
  }
}

//  RaisedButton(
//                 onPressed: () {
//                   _firestore
//                                   .collection('Review')
//                                   .doc()
//                                   .set({
//     "Thanks for sharing your experience with Eat Street" :   _rating
//                               });
//                   // setState(() {
//                   //   _rating = count++;
//                   // });
//                 },
//                 child: Text("Click Me"),
//               ),
//           ],
