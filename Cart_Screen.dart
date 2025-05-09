import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/authentication.dart';
import 'package:customer_app/models/CartModel.dart';
import 'package:customer_app/sidebar/sidebar_layout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'BottomNavBar.dart';
import 'dart:async';

import 'Order_Status.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';

enum ViewState { loading, idle }

var cartState = ViewState.idle;
// ignore: deprecated_member_use
final usersRef = Firestore.instance.collection("CartData");

class Cart extends StatefulWidget {
  const Cart({
    Key key,
  }) : super(key: key);
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  CartModel cartModel = new CartModel();
  TextEditingController searchTextEditingController =
      new TextEditingController();
  bool isLoading = true;
  QuerySnapshot namee;
  String userName;
  String userEmail;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    await FirebaseFirestore.instance
        .collection('Customer')
        .where('Email', isEqualTo: FirebaseAuth.instance.currentUser.email)
        .get()
        .then((value) {
      print(value.docs.first.data()['Name']);
      print(value.docs.first.data()['Email']);
      userName = value.docs.first.data()['Name'];
      userEmail = value.docs.first.data()['Email'];
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.orange,
                title: Center(
                  child: Text(
                    "Cart  ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Times New Roman"),
                  ),
                ),
                automaticallyImplyLeading: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              body: (cartState == ViewState.loading)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(mainAxisSize: MainAxisSize.max, children: [
                      Column(
                        children: [
                          Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset('assets/es2.jpg',
                                          width: 80,
                                          height: 90,
                                          fit: BoxFit.cover),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Estimated delivery",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontFamily: "Times New Rouman",
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Now (30 min)",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "Times New Rouman",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 5.0, left: 60.0, right: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Text(
                                    "Name ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Text(
                                    "Quantity ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Text(
                                    "Price ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ]),
                        ],
                      ),
                      Consumer<CartModel>(builder: (context, cart, child) {
                        int total = 0;
                        for (var a in cart.selectedProducts) {
                          total += int.parse(a['Price']);
                        }

                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                    itemCount: cart.selectedProducts.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return cartTile(
                                          cart.selectedProducts[index]);
                                    }),
                              ),
                              TotalButton(
                                cart: cart,
                                total: total,
                                customerName: userName,
                                customerEmail: userEmail,
                              )
                            ],
                          ),
                        );
                      }),
                    ]),
            ),
          );
  }

  cartTile(Map<String, String> cart) {
    // print("anmol is best ");
    // print(cart['Customer Name']);
    return Column(
      children: [
        Container(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 55.0,
                              height: 55.0,
                              child: CircleAvatar(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.green,
                                backgroundImage: NetworkImage(
                                  cart['Image'],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 18),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    cart['Name'],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(cart['Quantity']),
                                  SizedBox(width: 35),
                                  Text(cart['Price']),
                                  _delete(
                                    cart,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Container(
              //   child: Text("Toatal: $total"),
              // )
              // change(total),
            ],
          ),
        ),
        // Container(
        //   child: Text(cart['Customer Name']),
        //   //_deleteall(cart),
        // ),
      ],
    );
  }

  Widget _delete(Map<String, String> selectedProduct) {
    // ignore: non_constant_identifier_names
    return Consumer<CartModel>(builder: (context, CartModel, child) {
      return IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  title: Text(
                    "Delete",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontFamily: "Times New Roman",
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  content: Text(
                    "Do You Want To Delete?",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "Times New Roman"),
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () async {
                        CartModel.removeFromCart(
                          selectedProduct,
                        );
                        Navigator.pop(context);
                      },
                      child: Text("Yes"),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("No"),
                    ),
                  ],
                );
              },
            );
          });
    });
  }

  // customer(Map<String, String> map) {
  //   Consumer<CartModel>(builder: (context, CartModel, child) {
  //     return Column(
  //       childern[
  //           CartModel.getUserByUsername(map)
  //       ]);
  //   });
  // }
}

class TotalButton extends StatefulWidget {
  final CartModel cart;
  final total;
  final String customerName;
  final String customerEmail;
  TotalButton({
    this.cart,
    this.total,
    this.customerName,
    this.customerEmail,
  });
  @override
  _TotalButtonState createState() => _TotalButtonState();
}

class _TotalButtonState extends State<TotalButton> {
  @override
  Widget build(BuildContext context) {
    print('ahakdhkahdakdh${widget.customerName}');

    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 35),
              child: IconButton(
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 70,
                  ),
                  onPressed: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          title: Text(
                            "Delete",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: "Times New Roman",
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          content: Text(
                            "Do You Want To Delete?",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "Times New Roman"),
                          ),
                          actions: [
                            FlatButton(
                              onPressed: () async {
                                await widget.cart
                                    .deleteRecord(widget.total, widget.cart);
                                cartState = ViewState.idle;
                                widget.cart.getData();
                                Navigator.pop(context);
                              },
                              child: Text("Yes"),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("No"),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ),
            SizedBox(
              width: 20,
            ),
            FlatButton(
              onPressed: () async {
                if (widget.total != 0) {
                  if (widget.customerEmail != "guest@gmail.com") {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            title: Text(
                              "Place Order",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontFamily: "Times New Roman",
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            content: Text(
                              "Do You Want To Place Order?",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontFamily: "Times New Roman"),
                            ),
                            actions: [
                              FlatButton(
                                onPressed: () async {
                                  await widget.cart.createRecord(
                                      widget.total,
                                      widget.cart,
                                      widget.customerName,
                                      widget.customerEmail);

                                  cartState = ViewState.idle;
                                  widget.cart.getData();
                                  if (mounted) {
                                    setState(() {});
                                  }

                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: SideBarLayout()));

                                  // Navigator.push(
                                  //     context,
                                  //     PageTransition(
                                  //         type: PageTransitionType.fade, child: OrderStatus()));
                                },
                                child: Text("Yes"),
                              ),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("No"),
                              ),
                            ],
                          );

                          // await widget.cart.createRecord(widget.total, widget.cart,
                          //     widget.customerName, widget.customerEmail);

                          // cartState = ViewState.idle;
                          // widget.cart.getData();
                          // }
                          //   if (mounted) {
                          //     setState(() {});
                          //   }

                          //   Navigator.push(
                          //       context,
                          //       PageTransition(
                          //           type: PageTransitionType.fade,
                          //           child: SideBarLayout()));

                          //   // Navigator.push(
                          //   //     context,
                          //   //     PageTransition(
                          //   //         type: PageTransitionType.fade, child: OrderStatus()));
                          // }
                        });
                  } else {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          title: Text(
                            "Thanks 4 Visiting !!",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: "Times New Roman",
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          content: Text(
                            "But You Can't Place Your Order" +
                                "\n"
                                    "You Must Log-In to Place Your Order",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: "Times New Roman"),
                          ),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: Authentication_Screen()));
                              },
                              child: Text("Ok"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                } else {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        title: Text(
                          "Sorry !!",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontFamily: "Times New Roman",
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        content: Text(
                          "Your Cart is Empty",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontFamily: "Times New Roman"),
                        ),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      );
                    },
                  );
                } //else

                // await Future.delayed(
                //     Duration(
                //       seconds: 1,
                //     ), () {
                //   if (mounted) {
                //     setState(() {

                //     });
                //   }
                //   // Navigator.pop(context);
                // });
                // dialog();
                // showDialog(
                //     context: context,
                //     child: AlertDialog(
                //       title: Text("Success"),
                //       content: Text("Order Successfully send"),
                //       actions: [
                //         FlatButton(
                //           child: Text("OK"),
                //           onPressed: () {
                //             print("On success ok pressed");
                //           },
                //         )
                //       ],
                //     ));
                // AwesomeDialog(
                //     context: context,
                //     animType: AnimType.LEFTSLIDE,
                //     headerAnimationLoop: false,
                //     dialogType: DialogType.SUCCES,
                //     title: 'Succes',
                //     desc: 'order successfully send',
                //     btnOkOnPress: () {
                //       debugPrint('OnClcik');
                //     },
                //     btnOkIcon: Icons.check_circle,
                //     onDissmissCallback: () {
                //       debugPrint('Dialog Dissmiss from callback');
                //     })
                //   ..show();
              },
              child: Container(
                width: 250,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.orange[800],
                ),
                child: Center(
                  child: Text(
                    "Place Order: ${widget?.total ?? ''}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: "Times New Roman"),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

//   void dialog() {
//     // ignore: deprecated_member_use
//     usersRef.getDocuments().then((QuerySnapshot snapshot) {
//       // ignore: deprecated_member_use

//       String order_no;

//       // ignore: deprecated_member_use
//       snapshot.documents.forEach((DocumentSnapshot doc) {
//         // ignore: deprecated_member_use

//         // ignore: deprecated_member_use

//         setState(() {
//           // ignore: deprecated_member_use
//           order_no = doc.documentID;
//         });

//         // ignore: deprecated_member_use
//         print(doc.documentID);
//       });

//       print("helooo" + order_no);
//       dialogg(order_no);
//       // dialogg(order_no);
//     });
//   }

//   void dialogg(String order_no) {
//     String detail = "Order Successfully send";
//     String order = "Your order no : ";

//     showDialog(
//         context: context,
//         child: AlertDialog(
//           title: Text("Success"),
//           content: Text(detail + "\n" + order + " " + order_no),
//           actions: [
//             FlatButton(
//                 child: Text("OK"),
//                 onPressed: () {
//                   print("On success ok pressed");
//                   setState(() {
//                     Navigator.of(context).pushNamed(BottomNavBar.routeName);
//                   });
//                 })
//           ],
//         ));
//   }
}
