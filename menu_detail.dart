import 'package:customer_app/Cart_Screen.dart';
import 'package:customer_app/models/CartModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'dart:async';
import 'models/CartModel.dart';

class Menu_detail extends StatefulWidget {
  final String imageUrl;
  final String name;
  final String detail;
  final String price;
  String prc;
  int ct = 1;

  Menu_detail({this.imageUrl, this.name, this.detail, this.price, this.ct});
  @override
  _Menu_detailState createState() => _Menu_detailState();
}

class _Menu_detailState extends State<Menu_detail> {
  // bool colorchange2 = false;
  int count = 1;
  String prc;
  String prrc;
  int ct = 1;
  String pt;
  final _controller = TextEditingController();

  @override
  void initState() {
    prc = widget.price;
    prrc = widget.price;
    super.initState();

    // _populateData();
    // super.initState();
  }

  @override
  Menu_detail get widget => super.widget;
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cartModel, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                title: Text('Menu Detail'),
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 15, right: 25),
                    child: Badge(
                      badgeContent:
                          Text('${cartModel.selectedProducts.length}'),
                      child: IconButton(
                        icon: Icon(Icons.shopping_cart, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Cart()));
                        },
                      ),
                      badgeColor: Colors.red,
                    ),
                  ),
                ],
              ),
              body: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  SizedBox(
                    height: 5.0,
                  ),
                  _image(),
                  _detail(),
                ],
              ))),
    );
  }

  Widget _image() {
    return Image(
      image: NetworkImage(widget.imageUrl),
      height: 250.0,
    );
  }

  Widget _detail() {
    return Consumer<CartModel>(
      builder: (context, model, child) => Container(
          child: Column(children: [
        Text(
          widget.name,
          style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontStyle: FontStyle.italic,
              fontFamily: "Times New Roman"),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
          child: Text(
            widget.detail,
            style: TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontFamily: "Times New Roman"),
          ),
        ),
        SizedBox(
          height: 80,
        ),
        Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
                  child: Text(
                    prc.toString() + " " " Rs. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Times New Roman"),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
                  child: Container(
                    height: 40,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          child: Icon(Icons.remove),
                          onTap: () {
                            setState(() {
                              if (count > 1) {
                                prc = widget.price;
                                count--;
                                prc = (int.parse(prc.replaceAll('.Rs', '')) *
                                        count)
                                    .toString();
                                prc = '$prc';
                                ct = count;
                                print(ct);
                              }
                            });
                          },
                        ),
                        Text(
                          count.toString(),
                          style: TextStyle(fontSize: 18),
                        ),
                        GestureDetector(
                          child: Icon(Icons.add),
                          onTap: () {
                            setState(() {
                              if (count < 20) {
                                prc = widget.price;
                                count++;
                                prc = (int.parse(prc.replaceAll('.Rs', '')) *
                                        count)
                                    .toString();
                                prc = '$prc';
                                ct = count;
                                print(ct);
                                if (count == 20) {
                                  Fluttertoast.showToast(
                                      msg: "you can only order 20 qty ");
                                }
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Row(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Padding(
            //       padding:
            //           const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
            //       child: Text(
            //         prrc.toString(),
            //         textAlign: TextAlign.center,
            //         style: TextStyle(
            //             fontSize: 20,
            //             color: Colors.black,
            //             fontStyle: FontStyle.italic,
            //             fontFamily: "Times New Roman"),
            //       ),
            //     ),
            //     Padding(
            //       padding:
            //           const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
            //       child: Container(
            //           height: 40,
            //           width: 120,
            //           decoration: BoxDecoration(
            //               color: Colors.orange,
            //               borderRadius: BorderRadius.circular(20)),
            //           child: FlatButton(
            //             onPressed: () {
            //               setState(() {
            //                 prrc = widget.price;
            //                 pt = _controller.text;
            //                 print(pt);

            //                 String g;

            //                 // pt =
            //                 // // prrc * pt;
            //                 prrc = (int.parse(prrc.replaceAll('.Rs', '')) *
            //                         int.parse(pt.replaceAll('.Rs', '')))
            //                     .toString();
            //                 prrc = '$prrc.Rs';
            //                 print(prrc);
            //               });
            //             },
            //             child: TextField(
            //               controller: _controller,
            //               decoration: InputDecoration(
            //                   hintText: "type Quantity for big order",
            //                   labelStyle:
            //                       TextStyle(fontSize: 15, color: Colors.black)),
            //               keyboardType: TextInputType.number,
            //             ),
            //           )),
            //     ),
            //   ],
            // ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(
            child: Text(
              'Add To Cart',
              style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  fontFamily: "Times New Roman"),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.all(15),
            color: Colors.orange,
            textColor: Colors.white,
            onPressed: () {
              Provider.of<CartModel>(context, listen: false).add({
                "Image": "${widget.imageUrl}",
                "Name": "${widget.name}",
                "Price": "${prc.toString()}",
                "Quantity": "${count.toString()}",
                //"timestamp": getTime
              });
              // model.setCartAmount();
              //  SnackBar s = SnackBar(content: Text("Product is added"));
              //  Scaffold.of(context).showSnackBar(s);
            },
          ),
        ),
      ])),
    );
  }
}
