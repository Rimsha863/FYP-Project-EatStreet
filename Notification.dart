import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customer_app/deals_detail.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            _slider(),
          ],
        ),
      ),
    );
  }

  Widget _slider() {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/noti.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(top: 100, left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Text(
                      "Big Buys, But Bigger Savings",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Price is your beautiful smile",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontFamily: "Times New Roman",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 1.0)),
                    Text(
                      'Notification',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontFamily: "Times New Roman"),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          top: 2.0, left: 5.0, right: 5.0, bottom: 2.0),
                    ),
                    _data(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _data() {
    return Container(
      height: 458,
      child: PageView(
        pageSnapping: false,
        children: <Widget>[
          _noti(),
        ],
      ),
    );
  }

  Widget _noti() {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Deals").snapshots(),
          builder: (context, snapshot) {
            return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot deals = snapshot.data.documents[index];
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
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
                                    backgroundImage:
                                        NetworkImage(deals.data()['Image']),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      deals.data()['Name'],
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      deals.data()['Price'],
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => deals_detail(
                                            imagee: deals.data()['Image'],
                                            namee: deals.data()['Name'],
                                            pricee: deals.data()['Price'],
                                            detaill: deals.data()['Detail'],
                                          )));
                                },
                                color: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Text('View'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
