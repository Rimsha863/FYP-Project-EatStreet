import 'dart:math';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Cart_Screen.dart';
import 'package:intl/intl.dart';

class CartModel extends ChangeNotifier {
  int counter = 0;
  String detail = "Order Successfully send";
  String order = "Your order no : ";

  int _remainingTime = 60;
  int getRemainingTime() => _remainingTime;

  updateRemainingTime() {
    _remainingTime--;
    notifyListeners();
  }

  var context;
  setCartAmount() {
    counter++;
  }

  final databaseReference = FirebaseFirestore.instance;
  List<Map<String, String>> _selectedProducts = List<Map<String, String>>();
  int _total = 0;
  List<Map<String, String>> get selectedProducts => _selectedProducts;

  // List<Map<String, String>> _customerName = List<Map<String, String>>();

  // List<Map<String, String>> get customerName => _customerName;

  void add(Map<String, String> value) {
    _selectedProducts.add(value);
    print("Rimsha is best");
    print(value);
    notifyListeners();
  }

  // void addcustomer(Map<String, String> value) {
  //   _customerName.add(value);
  //   print(value);
  //   notifyListeners();
  // }

  removeFromCart(Map<String, String> value) {
    _selectedProducts.remove(value);

    notifyListeners();
  }

  // removeall(Map<String, String> value) {
  //   _selectedProducts.clear();
  //   notifyListeners();
  // }

  // createRecord(total, cart) async {
  //   print("@CreateRecord/CartData");

  //   const _chars =
  //       'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  //   Random _rnd = Random();

  //   String getRandomString(int length) =>
  //       String.fromCharCodes(Iterable.generate(
  //           length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  //   var randomString = getRandomString(5); // 5GKjb

  //   cartState = ViewState.loading;
  //   await databaseReference.collection("CartData").doc(randomString).set({
  //     "cartItems": selectedProducts.toString(),
  //     "totalCost": total,
  //     "order number": randomString
  //   });
  //   print(selectedProducts.toString());
  //   notifyListeners();
  // }

  deleteRecord(total, cart) async {
    _selectedProducts.clear();
    notifyListeners();
  }

  createRecord(total, cart, customerName, customerEmail) async {
    print("@CreateRecord/CartData");
    print('In create Record $customerName');

    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String getRandomString(int length) =>
        String.fromCharCodes(Iterable.generate(
            length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
    var randomString = getRandomString(5); // 5GKjb

    // selectedProducts.add({'totalCost': total.toString()});
    //cartState = ViewState.loading;
    DateTime selectedDT = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(selectedDT);
    await databaseReference.collection("CartData").doc(randomString).set({
      "Email": customerEmail,
      "Customer Name": customerName,
      "order number": randomString,
      'orders': FieldValue.arrayUnion(selectedProducts),
      'totalCost': total.toString(),
      'Date': formattedDate,
      // selectedDT.year.toString() +
      //     "-" +
      //     selectedDT.month.toString() +
      //     "-" +
      //     selectedDT.day.toString(),
      // // +
      // " " +
      // selectedDT.timeZoneName,
      "Time": DateFormat.jm().format(selectedDT),

      //'customerName': customerName
      // 'Image': selectedProducts[0]['Image'],
      // 'Name': selectedProducts[0]["Name"],
      // 'Price': selectedProducts[0]['Price'],
      // 'Quantity': selectedProducts[0]['Quantity'],
      // 'totalCost': total
    }).whenComplete(() => selectedProducts.clear());

    print(selectedProducts.toString());
    notifyListeners();
  }

  void getData() async {
    print("@getCartDataRecords");
    await for (var snapshot
        in databaseReference.collection('CartData').snapshots()) {
      for (var message in snapshot.docs) {
        print(message.data());
      }
    }
    print("read succesffully");
    notifyListeners();
  }

  Future<void> getUserByUsername(Map<String, String> map) async {
    print(map);
    // ignore: deprecated_member_use
    return await Firestore.instance
        .collection('Customer')
        .where("Name", isEqualTo: map)
        // ignore: deprecated_member_use
        .getDocuments();
  }
}
