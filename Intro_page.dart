import 'dart:async';
import 'package:customer_app/Login.dart';
import 'package:customer_app/authentication.dart';
import 'package:customer_app/model/slide.dart';
import 'package:customer_app/widgets/slide_dots.dart';
import 'package:customer_app/widgets/slide_item.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'BottomNavBar.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
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
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    PageView.builder(
                      scrollDirection: Axis.horizontal,
                      controller: _pageController,
                      onPageChanged: _onPageChanged,
                      itemCount: slideList.length,
                      itemBuilder: (ctx, i) => SlideItem(i),
                    ),
                    Stack(
                      alignment: AlignmentDirectional.topStart,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(bottom: 35),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              for (int i = 0; i < slideList.length; i++)
                                if (i == _currentPage)
                                  SlideDots(true)
                                else
                                  SlideDots(false)
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Getting Started',
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
                      Navigator.of(context).pushNamed(BottomNavBar.routeName);
                    },
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Text(
                  //       'Have an account?',
                  //       style: TextStyle(
                  //           fontSize: 18,
                  //           fontStyle: FontStyle.italic,
                  //           fontFamily: "Times New Roman"),
                  //     ),
                  //     FlatButton(
                  //       child: Text(
                  //         'Login',
                  //         style: TextStyle(
                  //             fontSize: 18,
                  //             fontStyle: FontStyle.italic,
                  //             fontFamily: "Times New Roman"),
                  //       ),
                  //       onPressed: () {
                  //         Navigator.push(
                  //             context,
                  //             PageTransition(
                  //                 type: PageTransitionType.fade,
                  //                 child: Authentication_Screen()));
                  //       },
                  //     ),
                  //   ],
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
