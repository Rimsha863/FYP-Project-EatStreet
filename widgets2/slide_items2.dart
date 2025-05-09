import 'package:customer_app/model/slide.dart';
import 'package:customer_app/model/slide2.dart';
import 'package:flutter/material.dart';

class SlideItem2 extends StatelessWidget {
  final int index;
  SlideItem2(this.index);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            slideList2[index].title,
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontFamily: "Times New Roman"),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            slideList2[index].title2,
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontFamily: "Times New Roman"),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            width: 200,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    // Lottie.asset('assets/clock.json',
//                                     width: 80, height: 80),

                    image: AssetImage(slideList2[index].image),
                    fit: BoxFit.cover)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            slideList2[index].description,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontFamily: "Times New Roman"),
          ),
          Container(
            width: 200,
            height: 150,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    // Lottie.asset('assets/clock.json',
//                                     width: 80, height: 80),

                    image: AssetImage(slideList2[index].imagee),
                    fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
