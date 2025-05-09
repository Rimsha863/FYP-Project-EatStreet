import 'dart:async';

import 'package:customer_app/Animations/FadeAnimation.dart';
import 'package:customer_app/models/CartModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  AnimationController _animationController;
  StreamController<bool> isSidebarOpenedStreamController;
  Stream<bool> isSidebarOpenedStream;
  StreamSink<bool> isSidebarOpenedSink;
  final _animationDuration = const Duration(milliseconds: 500);
  CartModel cartModel = new CartModel();
  TextEditingController searchTextEditingController =
      new TextEditingController();
  bool isLoading = true;
  QuerySnapshot namee;
  String userName;
  String userOrderNumber;
  String totalprice;

  @override
  void initState() {
    getUserData();
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSidebarOpenedStreamController = PublishSubject<bool>();
    isSidebarOpenedStream = isSidebarOpenedStreamController.stream;
    isSidebarOpenedSink = isSidebarOpenedStreamController.sink;
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
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

  getUserData() async {
    DateTime selectedDT = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(selectedDT);
    await FirebaseFirestore.instance
        .collection('CartData')
        .where('Email', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .where(
          'Time',
          isEqualTo: DateFormat.jm().format(selectedDT),
        )
        .get()
        .then((value) {
      print(value.docs.first.data()['Name']);
      print(value.docs.first.data()['order number']);
      userName = value.docs.first.data()['Customer Name'];
      userOrderNumber = value.docs.first.data()['order number'];
      totalprice = value.docs.first.data()['totalCost'];
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSidebarOpenedStreamController.close();
    isSidebarOpenedSink.close();
    super.dispose();
    _pageController.dispose();
  }

  void onIconPressed() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSidebarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSidebarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

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

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
      initialData: true,
      stream: isSidebarOpenedStream,
      builder: (context, isSideBarOpenedAsync) {
        return AnimatedPositioned(
          duration: _animationDuration,
          top: 0,
          bottom: 0,
          left: isSideBarOpenedAsync.data ? 0 : -screenWidth,
          right: isSideBarOpenedAsync.data ? 0 : screenWidth - 45,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/logo.png', width: 150),

                      // Divider(),
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
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => ChatRoom()));
                            //_chat();
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                          ],
                        ),
                      ),
                      Divider(),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              child: Container(
                                margin: const EdgeInsets.only(top: 1),
                                width: 550,
                                height: 100,
                                padding: EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(color: Colors.black38)),
                                child: Center(
                                  child: Column(
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("Customer Number : "),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(userName)
                                          ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("Order Number : "),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(userOrderNumber)
                                          ]),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Divider(),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text("Total Price : "),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(totalprice)
                                          ]),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment(0, -0.9),
                child: GestureDetector(
                  onTap: () {
                    onIconPressed();
                  },
                  child: ClipPath(
                    clipper: CustomMenuClipper(),
                    child: Container(
                      width: 35,
                      height: 110,
                      color: Colors.orange,
                      alignment: Alignment.centerLeft,
                      child: AnimatedIcon(
                        progress: _animationController.view,
                        icon: AnimatedIcons.arrow_menu,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class Feedback extends StatefulWidget {
  @override
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  String userName;
  @override
  void initState() {
    super.initState();
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
