import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final _firestore = FirebaseFirestore.instance;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  // initState() {
  //   Navigator.pop(context);
  //   super.initState();
  // }

  _sendMessageArea() {
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
                    "Customer message": _controller.text,
                  },
                ).whenComplete(() => _controller.clear());
              }),
        ],
      ),
    );
  }

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
          Expanded(
            child: Column(
              children: [
                Container(
                  child: Text("data"),
                ),
                Container(
                  child: Text("data"),
                ),
                Container(
                  child: Text("data"),
                ),
              ],
            ),
          ),
          _sendMessageArea(),
        ],
      ),
    );
  }
}
