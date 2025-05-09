import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Tdata extends StatefulWidget {
  @override
  _TdataState createState() => _TdataState();
}

class _TdataState extends State<Tdata> {
  final _firestore = Firestore.instance;

  // Widget _data() {
  //   final col = _firestore.collection('CartData');
  //   final query = col.where('orders');
  //   query.get().then((snapshot) => {
  //         snapshot.docs.forEach((doc) {
  //         var length;
  //         for (int i = 0; i < 10; i++){}
  //           var t = doc.data();

  //           var m = doc.id;
  //           print(m);
  //           print(t);
  //         })
  //       });
  // }

  int counter = 20;
  @override
  void initState() {
    if (counter == 20) {
      counter--;
      Lottie.asset('assets/clock.json', width: 80, height: 80);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
