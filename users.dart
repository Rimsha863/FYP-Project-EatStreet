import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final GoogleSignIn googleSignIn = GoogleSignIn();

String name;
String email;
String imageUrl;

Future<String> signInWithGoogle() async {
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  // ignore: deprecated_member_use
  final AuthCredential credential = GoogleAuthProvider.getCredential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  UserCredential result = (await _auth.signInWithCredential(credential));
  // ignore: deprecated_member_use
  final FirebaseUser user = result.user;

  assert(user.email != null);
  assert(user.displayName != null);
  assert(user.photoURL != null);

  name = user.displayName;
  email = user.email;
  imageUrl = user.photoURL;

  // ignore: deprecated_member_use
  final FirebaseUser currentUser = await _auth.currentUser;
  assert(user.uid == currentUser.uid);

  return 'signInWithGoogle succeeded ; $user';
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("user Sign Out");
}
