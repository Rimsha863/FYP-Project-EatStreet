import 'dart:async';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/menu_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import 'Cart_Screen.dart';
import 'models/CartModel.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  String Active;
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
        builder: (context, cartModel, child) => Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  _image(),
                  _opacity(),
                  _data(),
                ],
              ),
            ));
  }

  Widget _image() {
    return Image(
      image: AssetImage('assets/menu.jpg'),
      height: 350,
      fit: BoxFit.cover,
    );
  }

  Widget _opacity() {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
      Colors.black.withOpacity(.5),
      Colors.black.withOpacity(.3),
      Colors.black.withOpacity(.2),
    ])));
  }

  Widget _data() {
    return Column(
      children: [
        _menu(),
        _title(),
        _deliverytime(),
      ],
    );
  }

  Widget _menu() {
    return Consumer<CartModel>(
        builder: (context, cartModel, child) => SafeArea(
                child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  Badge(
                    badgeContent: Text('${cartModel.selectedProducts.length}'),
                    child: IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => Cart()));
                      },
                    ),
                    badgeColor: Colors.red,
                  ),
                ],
              ),
            )));
  }

  Widget _title() {
    return Container(
      height: 100,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Menu',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontFamily: "Times New Roman",
              // fontWeight: FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }

  Widget _deliverytime() {
    return Container(
      height: 489,
      child: PageView(
        pageSnapping: false,
        children: [
          _time(),
        ],
      ),
    );
  }

  Widget _time() {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Menu").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1.0,
                  mainAxisSpacing: 1.0),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                DocumentSnapshot menu = snapshot.data.documents[index];

                return menu.data()['Active'] != 'Active'
                    ? Container(
                        margin: EdgeInsets.only(left: 10.0, top: 10.0),
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Container(
                              width: 150.0,
                              child: Card(
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Wrap(
                                  children: <Widget>[
                                    ClipRRect(
                                      child: Image.network(
                                        menu.data()['Image'],
                                      ),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Center(
                                      child: Text(
                                        menu.data()['Name'],
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Times New Roman'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        menu.data()['Price'] + " " "Rs",
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'Times New Roman'),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                        child: Text(
                                      "Not Available",
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontStyle: FontStyle.italic,
                                          fontFamily: 'Times New Roman',
                                          color: Colors.red),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.only(left: 10.0, top: 10.0),
                        height: 50,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                print(
                                  menu.data()['Price'],
                                );
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => Menu_detail(
                                    imageUrl: menu.data()['Image'],
                                    name: menu.data()['Name'],
                                    price: menu.data()['Price'],
                                    detail: menu.data()['Detail'],
                                  ),
                                ));
                              },
                              child: Container(
                                width: 150.0,
                                child: Card(
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Wrap(
                                    children: <Widget>[
                                      ClipRRect(
                                        child: Image.network(
                                          menu.data()['Image'],
                                        ),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(16.0),
                                          topRight: Radius.circular(16.0),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Center(
                                        child: Text(
                                          menu.data()['Name'],
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Times New Roman'),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          menu.data()['Price'] + " " " Rs ",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            fontStyle: FontStyle.italic,
                                            fontFamily: 'Times New Roman',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Available",
                                          style: TextStyle(
                                              fontSize: 15.0,
                                              fontStyle: FontStyle.italic,
                                              fontFamily: 'Times New Roman',
                                              color: Colors.green),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
              }
              //}
              );
        },
      ),
    );
  }
}
