import 'package:customer_app/Cart_Screen.dart';
import 'package:customer_app/models/CartModel.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';

import 'package:badges/badges.dart';
import 'dart:async';
import 'models/CartModel.dart';

class deals_detail extends StatefulWidget {
  final String imagee;
  final String namee;
  final String detaill;
  final String pricee;
  String prc;
  int ct = 1;

  deals_detail({this.imagee, this.namee, this.detaill, this.pricee, this.ct});
  @override
  _deals_detailState createState() => _deals_detailState();
}

class _deals_detailState extends State<deals_detail> {
  // bool colorchange2 = false;
  int count = 1;
  String prc;
  int ct = 1;

  @override
  void initState() {
    prc = widget.pricee;
    super.initState();

    // _populateData();
    // super.initState();
  }

  @override
  deals_detail get widget => super.widget;
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
      image: NetworkImage(widget.imagee),
      height: 250.0,
    );
  }

  Widget _detail() {
    return Consumer<CartModel>(
        builder: (context, model, child) => Container(
                child: Column(children: [
              Text(
                widget.namee,
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
                  widget.detaill,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontStyle: FontStyle.italic,
                      fontFamily: "Times New Roman"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, right: 10.0, top: 5),
                    child: Text(
                      prc.toString(),
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
                                  prc = widget.pricee;
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
                                prc = widget.pricee;
                                count++;
                                prc = (int.parse(prc.replaceAll('.Rs', '')) *
                                        count)
                                    .toString();
                                prc = '$prc';
                                ct = count;
                                print(ct);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
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
                      "Image": "${widget.imagee}",
                      "Name": "${widget.namee}",
                      "Price": "${prc.toString()}",
                      "Quantity": "${count.toString()}",
                      //"timestamp": getTime
                    });
                    // model.setCartAmount();
                    //  SnackBar s = SnackBar(content: Text("Product is added"));
                    //  Scaffold.of(context).showSnackBar(s);
                  },
                ),
              )
            ])));
  }
}
