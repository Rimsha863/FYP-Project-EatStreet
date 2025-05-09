import 'package:customer_app/model/slide.dart';
import 'package:flutter/material.dart';

class SlideItem extends StatelessWidget {
  final int index;
  SlideItem(this.index);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 550,
          height: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                  image: AssetImage(slideList[index].image),
                  fit: BoxFit.cover)),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          slideList[index].title,
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontFamily: "Times New Roman"),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          slideList[index].description,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontFamily: "Times New Roman"),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
