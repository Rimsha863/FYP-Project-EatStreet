import 'dart:async';
import 'package:customer_app/Intro_page.dart';
import 'package:customer_app/authentication.dart';
import 'package:customer_app/models/CartModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:page_transition/page_transition.dart';
import "package:customer_app/Animations/FadeAnimation.dart";
import 'package:provider/provider.dart';

import 'BottomNavBar.dart';

//where is the checkout screen
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider<CartModel>(
    create: (context) => CartModel(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      //routes: {
      // '/home': (_) => BottomNavBar(),
      //},
      routes: {
        BottomNavBar.routeName: (ctx) => BottomNavBar(),
        //SignupScreen.routeName: (ctx) => SignupScreen(),
      },
    ),
  ));
}

class AuthState extends StatefulWidget {
  @override
  _AuthStateState createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  User user;
  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;
    print('Initialiadingin main');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return user != null ? IntroPage() : Authentication_Screen();
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    super.initState();

    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _widthController.forward();
            }
          });

    _widthController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));

    _widthAnimation =
        Tween<double>(begin: 80.0, end: 300.0).animate(_widthController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _positionController.forward();
            }
          });

    _positionController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _positionAnimation =
        Tween<double>(begin: 0.0, end: 215.0).animate(_positionController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              setState(() {
                hideIcon = true;
              });
              _scale2Controller.forward();
            }
          });

    _scale2Controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    _scale2Animation =
        Tween<double>(begin: 1.0, end: 32.0).animate(_scale2Controller)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade, child: AuthState()));
            }
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: FadeAnimation(
                1.6,
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/bg1.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(
                      1.6,
                      Image.asset(
                        'assets/logo1.png',
                        width: 200.0,
                        height: 200.0,
                      )),
                  SizedBox(
                    height: 60,
                  ),
                  FadeAnimation(
                    1.6,
                    AnimatedBuilder(
                      animation: _scaleController,
                      builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _widthController,
                            builder: (context, child) => Container(
                              width: _widthAnimation.value,
                              height: 80,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.orange.withOpacity(.4),
                              ),
                              child: InkWell(
                                onTap: () {
                                  _scaleController.forward();
                                },
                                child: Stack(
                                  children: <Widget>[
                                    AnimatedBuilder(
                                      animation: _positionController,
                                      builder: (context, child) => Positioned(
                                        left: _positionAnimation.value,
                                        child: AnimatedBuilder(
                                          animation: _scale2Controller,
                                          builder: (context, child) =>
                                              Transform.scale(
                                            scale: _scale2Animation.value,
                                            child: Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.orange,
                                              ),
                                              child: hideIcon == false
                                                  ? Icon(
                                                      Icons.arrow_forward,
                                                      color: Colors.white,
                                                    )
                                                  : Container(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 150,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
