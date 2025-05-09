import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Ct extends StatefulWidget {
  @override
  _CtState createState() => _CtState();
}

class _CtState extends State<Ct> {
  final _firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.orange,
        title: Center(
          child: Text(
            "Contact your rider  ",
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
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 5, right: 20),
            child: Image.asset('assets/msg2.jpg',
                width: 50, height: 50, fit: BoxFit.cover),
          )
        ],
      ),
      body: Column(
        children: [
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("Messages").snapshots(),
              builder: (context, snapshot) {
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot deals = snapshot.data.documents[index];
                      return Stack(children: <Widget>[
                        Expanded(
                          child: Column(children: <Widget>[
                            Container(
                              alignment: Alignment.topRight,
                              child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.80,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    deals.data()['Customer-message'],
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          ]),
                        ),
                        data(),
                      ]);
                    });
              }),
        ],
      ),
    );
  }
}

class data extends StatefulWidget {
  @override
  _dataState createState() => _dataState();
}

class _dataState extends State<data> {
  final _firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      height: 70,
      color: Colors.white,
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.photo),
              iconSize: 25,
              color: Colors.orange,
              onPressed: () {}),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
          ),
          IconButton(
              icon: Icon(Icons.send),
              iconSize: 25,
              color: Colors.orange,
              onPressed: () {
                _firestore.collection('Messages').doc().set(
                  {
                    "Customer-message": _controller.text,
                  },
                ).whenComplete(() => _controller.clear());
              }),
        ],
      ),
    );
  }
}
