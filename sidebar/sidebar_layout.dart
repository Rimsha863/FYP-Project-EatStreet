import 'package:customer_app/BottomNavBar.dart';
import 'package:customer_app/Menu.dart';
import 'package:customer_app/main.dart';
import 'package:customer_app/sidebar/sidebar.dart';
import 'package:flutter/material.dart';

class SideBarLayout extends StatefulWidget {
  @override
  _SideBarLayoutState createState() => _SideBarLayoutState();
}

class _SideBarLayoutState extends State<SideBarLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BottomNavBar(),
          SideBar(),
        ],
      ),
    );
  }
}
