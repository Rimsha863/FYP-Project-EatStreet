import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SignOut extends StatefulWidget {
  @override
  _SignOutState createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
  final _firebaseAuth = FirebaseFirestore.instance;
  String email;
  String Password;

  Future signOut() async {
    try {
      return await FirebaseAuth.instance.signOut();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
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
                  child: Center(
                    child: CircleAvatar(
                      //  backgroundColor: Colors.white,
                      // foregroundColor: Colors.orange,
                      child: Center(
                        child: IconButton(
                            icon: Icon(
                              Icons.exit_to_app, color: Colors.white,
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
                                                  child: Login()));
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
                    ),
                  ),
                ),
              );
            }));
  }
}
