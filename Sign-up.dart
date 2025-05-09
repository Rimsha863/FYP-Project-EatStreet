import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/Intro_page.dart';
import 'package:customer_app/Login.dart';
import 'package:customer_app/authentication.dart';
import 'package:customer_app/authentication2.dart';
import 'package:customer_app/widgets/customTextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'Animations/FadeAnimation.dart';
import 'package:country_code_picker/country_code_picker.dart';

import 'BottomNavBar.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'models/CartModel.dart';

class Sign_up extends StatefulWidget {
  @override
  _Sign_upState createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  String name;
  String email;
  String password;
  String cpassword;
  String phone;
  // GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // ignore: deprecated_member_use
  final _firestore = Firestore.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

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

  // void validate() {
  //   if (formkey.currentState.validate()) {
  //     formkey.currentState.save();
  //     print("validated");
  //   } else {
  //     setState(() {
  //       Fluttertoast.showToast(msg: "Not Validated");
  //       Navigator.push(
  //           context,
  //           PageTransition(
  //               type: PageTransitionType.fade, child: Authentication_Screen()));
  //     });
  //     print("Not Validated");
  //   }
  // }

  String validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    } else if (value.length < 3) {
      return "Name must be more than 2 character";
    }
    return null;
  }

  String validatepass(value) {
    if (value.isEmpty) {
      return "Required *";
    } else if (value.length < 6) {
      return "Should Be At Least 6 characters";
    } else if (value != value) {
      return "Incoorect Pasword";
      // } else if (value != 92) {
      //   return "Only for Pakistan";
      // }
    } else {
      return null;
    }
  }

  // String validatepass1(value) {
  //   if (value.isEmpty) {
  //     return "Required *";
  //   } else if (validatepass.value != value) {
  //     return "Incorrect Password";
  //   } else {
  //     return null;
  //   }
  // }

  // String validatephone(value) {
  //   if (value.isEmpty) {
  //     return "Required *";
  //   } else if (value != 92) {
  //     return "Only for Pakistan";
  //   } else {
  //     return null;
  //   }
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
                  top: 20,
                ),
                child: FadeAnimation(
                    1.6,
                    Padding(
                      padding: const EdgeInsets.only(left: 130),
                      child: Text(
                        "Sign-Up",
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
                height: 20,
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                  child: FadeAnimation(
                      1.5,
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 50),
                              width: 500,
                              height: 350,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Form(
                                key: formkey,
                                autovalidate: true,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[300]))),
                                      child: TextFormField(
                                        textCapitalization:
                                            TextCapitalization.words,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(.8),
                                          ),
                                          prefixIcon: Icon(Icons.person),
                                          labelText: " Name",
                                        ),
                                        validator: validateName,
                                        onChanged: (val) {
                                          name = val;
                                        },
                                      ),
                                    ),
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
                                          labelText: "E-mail",
                                        ),
                                        validator: MultiValidator([
                                          RequiredValidator(
                                              errorText: "Required *"),
                                          EmailValidator(
                                              errorText: "Not A Valid Email"),
                                        ]),
                                        onChanged: (val) {
                                          email = val;
                                        },
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.grey[300]))),
                                      child: TextFormField(
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(.8),
                                          ),
                                          prefixIcon: Icon(Icons.lock),
                                          labelText: "Password",
                                        ),
                                        validator: validatepass,
                                        onChanged: (val) {
                                          password = val;
                                        },
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(),
                                      child: TextFormField(
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                            color: Colors.grey.withOpacity(.8),
                                          ),
                                          prefixIcon: CountryCodePicker(
                                            initialSelection: 'PK',
                                            showCountryOnly: false,
                                            showOnlyCountryWhenClosed: false,
                                            favorite: ['+92', 'PK'],
                                            enabled: true,
                                          ),
                                          labelText: "Phone Number",
                                        ),
                                        maxLength: 11,
                                        validator: (_val) {
                                          if (_val.isEmpty) {
                                            return "Required";
                                          }
                                          if (_val.length != 11) {
                                            return "Mobile Number must be of 11 digit";
                                          } else {
                                            return null;
                                          }
                                        },
                                        onChanged: (val) {
                                          phone = val;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 450, right: 20, left: 20),
                child: FadeAnimation(
                  1.8,
                  Center(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                        FlatButton(
                            child: Text(
                              'Sign-Up',
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
                              if (formkey.currentState.validate()) {
                                formkey.currentState.save();
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: email, password: password)
                                    .then((signedInUser) {
                                  _firestore
                                      .collection('Customer')
                                      .doc(name)
                                      .set({
                                    'Name': name,
                                    'Email': email,
                                    'Password': password,
                                    //'Confirm Password': cpassword,
                                    'PhoneNumber': phone,
                                  }).then((value) async {
                                    if (signedInUser != null) {
                                      Provider.of<CartModel>(context,
                                              listen: false)
                                          .getUserByUsername({
                                        "Customer Name": name,

                                        //"timestamp": getTime
                                      });

                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: Authentication2_Screen()));
                                    }
                                  }).catchError((e) {
                                    print(e);
                                  });
                                }).catchError((e) {
                                  print(e);
                                });
                              } else {
                                setState(() {
                                  Fluttertoast.showToast(msg: "Not Validated");
                                });
                                print("Not Validated");
                              }
                            }),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                          child: Text(
                            'As Guest',
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
                                    email: "guest@gmail.com",
                                    password: "guest123")
                                .then((signedInUser) {
                              _firestore
                                  .collection('Customer')
                                  .doc("guest")
                                  .set({
                                'Name': 'guest',
                                'Email': "guest@gmail.com",
                                'Password': "guest123",
                                //'Confirm Password': cpassword,
                              }).then((firebaseUser) {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: IntroPage()));
                              }).catchError((e) {
                                Fluttertoast.showToast(
                                    msg: "incorrect password ");
                              });
                            });
                          },
                        ),
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
                        //       )),
                        // )
                      ])),
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

//   bool _validator = false;
//   final TextEditingController _nameTextEditingController =
//       TextEditingController();
//   final TextEditingController _emailTextEditingController =
//       TextEditingController();
//   final TextEditingController _passwordTextEditingController =
//       TextEditingController();
//   final TextEditingController _cPasswordTextEditingController =
//       TextEditingController();
//   final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
//   String userImageUrl = "";
//   File _imageFile;

//   String email;
//   String password;
//   // GlobalKey<FormState> formkey = GlobalKey<FormState>();

//   // ignore: deprecated_member_use
//   final _firestore = Firestore.instance;

//   @override
//   Widget build(BuildContext context) {
//     double _screenWidth = MediaQuery.of(context).size.width,
//         _screenHeight = MediaQuery.of(context).size.height;
//     return SingleChildScrollView(
//       child: Container(
//         decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/b.jpg'), fit: BoxFit.cover)),
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             SizedBox(
//               height: 5.0,
//             ),
//             Form(
//               key: _formkey,
//               child: Column(
//                 children: [
//                   Text(
//                     "SIGN-IN",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 30,
//                       fontFamily: "Times New Roman",
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   CustomTextField(
//                     controller: _nameTextEditingController,
//                     data: Icons.person,
//                     hintText: "Name",
//                     isObsecure: false,
//                   ),
//                   CustomTextField(
//                     controller: _emailTextEditingController,
//                     data: Icons.email,
//                     hintText: "E-mail",
//                     isObsecure: false,

//                   ),
//                   CustomTextField(
//                     controller: _passwordTextEditingController,
//                     data: Icons.lock,
//                     hintText: "Password",
//                     isObsecure: true,
//                   ),
//                   CustomTextField(
//                     controller: _cPasswordTextEditingController,
//                     data: Icons.lock,
//                     hintText: "Confirm Password",
//                     isObsecure: true,
//                   ),
//                   CustomTextField(
//                     controller: _nameTextEditingController,
//                     data: Icons.phone,
//                     hintText: "Phone Number",
//                     isObsecure: false,
//                   ),
//                 ],
//               ),
//             ),
//             FlatButton(
//               child: Text(
//                 'Getting Started',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontStyle: FontStyle.italic,
//                     fontFamily: "Times New Roman"),
//               ),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(5),
//               ),
//               padding: const EdgeInsets.all(15),
//               color: Colors.orange,
//               textColor: Colors.white,
//               onPressed: () {
//                 Navigator.of(context).pushNamed(BottomNavBar.routeName);
//               },
//             ),
//             SizedBox(
//               height: 30.0,
//             ),
//             Container(
//               height: 4.0,
//               width: _screenWidth = 0.0,
//               color: Colors.orange,
//             ),
//             SizedBox(
//               height: 15.0,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
