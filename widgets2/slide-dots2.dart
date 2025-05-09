import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SlideDots2 extends StatelessWidget {
  bool isActive;
  SlideDots2(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.orange : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
