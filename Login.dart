import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/Animations/FadeAnimation.dart';
import 'package:customer_app/Forget_Screen.dart';
import 'package:customer_app/Home.dart';
import 'package:customer_app/Intro_page.dart';
import 'package:customer_app/Sign-up.dart';
//import 'package:customer_app/phone.dart';
import 'package:customer_app/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:customer_app/authentication.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:customer_app/Login.dart';

import 'BottomNavBar.dart';
import 'models/CartModel.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  CartModel cartModel = new CartModel();
  TextEditingController searchTextEditingController =
      new TextEditingController();
  bool isLoading = true;
  QuerySnapshot namee;
  String userName;
  String userPass;
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
      userPass = value.docs.first.data()['Password'];
    });
    setState(() {
      isLoading = false;
    });
  }

  String email;
  String password;
  // GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // ignore: deprecated_member_use
  final _firestore = Firestore.instance;
  // ignore: deprecated_member_use
  // FirebaseUser _user;
  //GoogleSignIn _googleSignIn = new GoogleSignIn();

  // final emailTextController = TextEditingController();
  // final passwordTextController = TextEditingController();

  // @override
  // void dispose() {
  //   emailTextController.dispose();
  //   passwordTextController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: double.infinity,
          child: Stack(
            children: [
              Positioned(
                child: FadeAnimation(
                  1.6,
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/bgg.jpg'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  top: 50,
                ),
                child: FadeAnimation(
                    1.6,
                    Padding(
                      padding: const EdgeInsets.only(left: 130),
                      child: Text(
                        "Log-In",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: "Times New Roman",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80, left: 15, right: 15),
                child: FadeAnimation(
                    1.5,
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50),
                          width: 500,
                          height: 150,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[300]))),
                                child: TextFormField(
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8),
                                    ),
                                    prefixIcon: Icon(Icons.email),
                                    labelText: " Enter The Email",
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: "Required *"),
                                    EmailValidator(
                                        errorText: "Not A Valid Email"),
                                  ]),
                                  onChanged: (val) {
                                    email = val;
                                  },
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(),
                                child: TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8),
                                    ),
                                    prefixIcon: Icon(Icons.lock),
                                    labelText: " Enter The Pasword",
                                  ),
                                  validator: (_val) {
                                    if (_val.isEmpty) {
                                      return "Required";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) {
                                    password = val;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                  width: double.infinity,
                                  child: InkWell(
                                      onTap: () {
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
                                                "Are you sure you want to reset your password?",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                    fontFamily:
                                                        "Times New Roman"),
                                              ),
                                              actions: [
                                                FlatButton(
                                                  onPressed: () async {
                                                    Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            child:
                                                                Forget_Screen()));
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
                                      },
                                      child: Text(
                                        "Forgot Password ?",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: "Times New Roman",
                                        ),
                                        textAlign: TextAlign.right,
                                      ))),
                            ))
                      ],
                    )),
              ),
              SizedBox(
                height: 150,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 340, right: 100, left: 80),
                child: FadeAnimation(
                  1.8,
                  Center(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              'Log-In',
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
                            onPressed: () async {
                              FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email, password: password)
                                  .then((firebaseUser) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: IntroPage()));
                              }).catchError((e) {
                                Fluttertoast.showToast(
                                    msg: "incorrect password ");
                              });
                            },
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Container(
                          //   width: 50,
                          //   child: Align(
                          //       alignment: Alignment.center,
                          //       child: MaterialButton(
                          //         onPressed: () {
                          //           signInWithGoogle().then((onValue) {
                          //             _firestore.collection('users').add({
                          //               'email': email,
                          //               'pass': password,
                          //               'image': imageUrl,
                          //             }).catchError((e) {
                          //               print(e);
                          //             }).then((onValue) {
                          //               Navigator.of(context)
                          //                   .pushNamed(BottomNavBar.routeName);
                          //             });
                          //           }).catchError((e) {
                          //             print(e);
                          //           });
                          //         },
                          //         child: Image(
                          //           image: AssetImage('assets/google_logo.png'),
                          //           width: 200.0,
                          //         ),
                          //       )),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // Container(
                          //   width: 50,
                          //   child: Align(
                          //       alignment: Alignment.center,
                          //       child: MaterialButton(
                          //         onPressed: () {},
                          //         child: Image(
                          //           image: AssetImage('assets/facebook.png'),
                          //           width: 200.0,
                          //         ),
                          //       )
                          // ),
                          // )
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  // bool isSignIn = false;
  // Future<void> handleSignIn() async {
  //   GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  //   GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount.authentication;

  //   // ignore: deprecated_member_use
  //   AuthCredential credential = GoogleAuthProvider.getCredential(
  //       idToken: googleSignInAuthentication.idToken,
  //       accessToken: googleSignInAuthentication.accessToken);

  //   UserCredential result = (await _auth.signInWithCredential(credential));

  //   _user = result.user;

  //   setState(() {
  //     isSignIn = true;
  //   });
  // }

  // Future<void> googleSignout() async {
  //   await _auth.signOut().then((onValue) {
  //     _googleSignIn.signOut();
  //     setState(() {
  //       isSignIn = false;
  //     });
  //   });
  // }
}
