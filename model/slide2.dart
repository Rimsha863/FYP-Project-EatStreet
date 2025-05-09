import 'package:flutter/cupertino.dart';
import 'dart:async';

class Slide2 {
  final String image;
  final String title;
  final String title2;
  final String description;
  final String imagee;

  Slide2({
    @required this.image,
    @required this.title,
    @required this.title2,
    @required this.description,
    @required this.imagee,
  });
}
// Lottie.asset('assets/clock.json',
//                                     width: 80, height: 80),

final slideList2 = [
  Slide2(
    image: 'assets/chef.gif',
    title: "15 - 25 mins",
    title2: "Estimated delivery time",
    description:
        " Preparing your food. Your rider will pick it up once it's ready",
    imagee: 'assets/2bar.gif',
  ),
  Slide2(
    image: 'assets/rider.gif',
    title: "5 - 15 mins",
    title2: "Estimated delivery time",
    description: "Your rider has picked up your food",
    imagee: 'assets/2bar.gif',
  ),
  Slide2(
    image: 'assets/meal.gif',
    title: "Enjoy your meal",
    title2: "",
    description: "",
    imagee: 'assets/2bar.gif',
  ),
];
