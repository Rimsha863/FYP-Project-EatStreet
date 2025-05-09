import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class Slideup extends StatefulWidget {
  @override
  _SlideupState createState() => _SlideupState();
}

class _SlideupState extends State<Slideup> {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
          // initialChildSize: 0.2,
          // minChildSize: 0.6,
          // maxChildSize: 0.8,
          builder: (BuildContext c, s) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10.0,
                )
              ]),
          child: ListView(
            controller: s,
            children: [
              Center(
                child: Container(
                  height: 8,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("HELLOOOOOOOOOO")
            ],
          ),
        );
      }),
    );

    
    
    // showCupertinoModalBottomSheet(
    //   context: context,
    //   builder: (context) => Container(),
    // );
  }
}

// /