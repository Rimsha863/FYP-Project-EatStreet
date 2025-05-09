import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:customer_app/Deals.dart';
import 'package:customer_app/Login.dart';
import 'package:customer_app/authentication.dart';
import 'package:customer_app/sign_out.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:async';

import 'Booking_page.dart';
import 'Home.dart';
import 'Menu.dart';
import 'Location.dart';
import 'Events.dart';
import 'Notification.dart';

class BottomNavBar extends StatefulWidget {
  static const routeName = 'BottomNavBar';
  //static const routeName = '/signup';

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  String noti;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  final _firebaseAuth = FirebaseFirestore.instance;
  String email;
  String Password;

  Future signOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
    } catch (e) {}
  }

  getUserData() async {
    StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Deals").snapshots(),
        builder: (context, snapshot) {
          return noti = snapshot.data.documents.length;
        });

    // await FirebaseFirestore.instance
    //     .collection('Customer')
    //     .where('E-mail', isEqualTo: FirebaseAuth.instance.currentUser.email)
    //     .get()
    //     .then((value) {
    //   print(value.docs.first.data()['Name']);
    //   userName = value.docs.first.data()['Name'];
    // });
    // setState(() {
    //   // isLoading = false;
    // });

//      FirebaseFirestore.instance.collection('Deals').doc().get().then(snap => {
//    size = snap.size // will return the collection size
// });
  }

  int selectedpage = 0;
  final _pageOption = [
    Menu(),
    Events(),
    // Loction(),
    Deals(),
    Booking_Page(),
    Notifications(),
    // SignOut(),
  ];
  @override
  Widget build(BuildContext context) {
    getUserData();
    return Scaffold(
      body: _pageOption[selectedpage],
      bottomNavigationBar: ConvexAppBar.badge(
        {
          4: _data(),
        },
        backgroundColor: Colors.orange,
        items: [
          TabItem(icon: Icons.restaurant_menu, title: "Menu"),
          TabItem(icon: Icons.event_seat, title: "Events"),
          //TabItem(icon: Icons.location_searching, title: "Location"),
          TabItem(icon: Icons.done_all, title: "Deals"),
          TabItem(icon: Icons.contacts, title: "Contact"),
          TabItem(
            //icon: _data(),
            icon: Icons.notifications_none,
            //title: "Notification"
          ),
          TabItem(
            icon: IconButton(
                icon: Icon(
                  Icons.exit_to_app, color: Colors.white,
                  size: 20,
                  // title: "Contact"
                ),
                onPressed: () {
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
                          "Sign-Out",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        content: Text(
                          "Are You Sure You Want To Sign-Out?",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: "Times New Roman"),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () async {
                              signOut();
                              Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: Authentication_Screen()));
                            },
                            child: Text("Yes"),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("No"),
                          ),
                        ],
                      );
                    },
                  );
                }),
          ),
          // title: "Sign-Out"

          // Icons.exit_to_app, title: "Sign-Out"
        ],
        initialActiveIndex: selectedpage,
        onTap: (int index) {
          setState(() {
            selectedpage = index;
          });
        },
      ),
    );
  }

  _data() {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Deals").snapshots(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      border: Border.all(color: Colors.white)),
                  child: Badge(
                    badgeContent: Text('${snapshot.data.documents.length}'),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.orange,
                        child: Center(
                          child: Icon(
                            Icons.notifications_none,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    badgeColor: Colors.red,
                  ),
                ),
              );
            }));
  }

//   _data1() {
//     return Scaffold(
//         backgroundColor: Colors.transparent,
//         body: StreamBuilder(
//             stream: FirebaseFirestore.instance.collection("Deals").snapshots(),
//             builder: (context, snapshot) {
//               return Padding(
//                 padding: const EdgeInsets.only(left: 10, bottom: 5),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(50),
//                       color: Colors.white,
//                       border: Border.all(color: Colors.white)),
//                   child: Center(
//                     child: CircleAvatar(
//                       //  backgroundColor: Colors.white,
//                       // foregroundColor: Colors.orange,
//                       child: Center(
//                         child: IconButton(
//                             icon: Icon(
//                               Icons.exit_to_app, color: Colors.white,
//                               // title: "Contact"
//                             ),
//                             onPressed: () {
//                               showDialog(
//                                 context: context,
//                                 barrierDismissible: false,
//                                 builder: (context) {
//                                   return AlertDialog(
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(20),
//                                       ),
//                                     ),
//                                     title: Text(
//                                       "Sign-Out",
//                                       style: TextStyle(
//                                         fontSize: 20,
//                                         color: Colors.black,
//                                         fontFamily: "Times New Roman",
//                                         fontStyle: FontStyle.italic,
//                                       ),
//                                     ),
//                                     content: Text(
//                                       "Are You Sure You Want To Sign-Out?",
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           color: Colors.black,
//                                           fontFamily: "Times New Roman"),
//                                     ),
//                                     actions: [
//                                       FlatButton(
//                                         onPressed: () async {
//                                           signOut();
//                                           Navigator.pushReplacement(
//                                               context,
//                                               PageTransition(
//                                                   type: PageTransitionType.fade,
//                                                   child: Login()));
//                                         },
//                                         child: Text("Yes"),
//                                       ),
//                                       FlatButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Text("No"),
//                                       ),
//                                     ],
//                                   );
//                                 },
//                               );
//                             }),
//                       ),
//                     ),
//                   ),
//                 ),
//               );
//             }));
//   }
}
