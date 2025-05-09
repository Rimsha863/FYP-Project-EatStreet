import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tryagain extends StatefulWidget {
  @override
  _TryagainState createState() => _TryagainState();
}

class _TryagainState extends State<Tryagain> {
  @override
  Widget build(BuildContext context) {
    DateTime now = new DateTime.now();
    return Column(
      children: [
        Text(
          DateFormat.yMMMd().format(now),
        ),
      ],
    );
  }
}

// class d extends StatefulWidget {
//   @override
//   _dState createState() => _dState();
// }

// class _dState extends State<d> {
//   @override
//   Widget build(BuildContext context) {
//     //DateTime now = new DateTime.now();
//     return Text("data");
//     //Text("Current Date: ${now.date}")
//   }
// }
