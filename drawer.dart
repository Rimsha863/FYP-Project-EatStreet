import 'package:customer_app/sidebar/sidebar_layout.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Dt extends StatefulWidget {
  @override
  _DtState createState() => _DtState();
}

class _DtState extends State<Dt> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: height,
        child: Stack(children: <Widget>[
          Container(
            child: Center(
              child: RaisedButton(
                  onPressed: () {
                    //MenuWidget();
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: SideBarLayout()));

                    // Positioned(
                    //     left: 0, bottom: -(height / 3), child: MenuWidget());
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  )),
            ),
          ),
          // Positioned(left: 0, bottom: -(height / 3), child: MenuWidget()),
        ]),
      ),
    );
  }
}

class MenuWidget extends StatefulWidget {
  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      child: Container(
        color: Colors.orange,
        width: width,
        height: height / 3 + 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
          child: Column(
            children: [
              Icon(
                Icons.keyboard_arrow_up,
                size: 20,
              ),
              Image.asset('assets/2bar.gif'),
            ],
          ),
        ),
      ),
    );
  }
}
