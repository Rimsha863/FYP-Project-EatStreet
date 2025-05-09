import 'package:flutter/cupertino.dart';
import 'dart:async';

class Slide {
  final String image;
  final String title;
  final String description;

  Slide({
    @required this.image,
    @required this.title,
    @required this.description,
  });
}

final slideList = [
  Slide(
    image: 'assets/1.png',
    title: "Certified Chef",
    description: " Cook Food Like Your Personel Chef",
  ),
  Slide(
    image: 'assets/2.png',
    title: "Fast Delivery",
    description: "Pick-up Delivery at Your Door and Enjoy the Deliouse Food",
  ),
  Slide(
      image: 'assets/3.png',
      title: "Easy Payment",
      description: "You Can Pay through Easy Paisa or Cash"),
];
