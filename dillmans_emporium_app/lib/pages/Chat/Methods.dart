import 'package:dillmans_emporium_app/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// look at ? mark at <User?> delete if code does not work
Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        //look at ? at User? delete if code does not work
        email: email,
        password: password);

    print("Account created Successful");

    userCredential.user!.updateDisplayName(name);

    await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
      //in case of problem, remove ? from currentUser?
      "name": name,
      "email": email,
      "status": "Unavailable",
      "uid": _auth.currentUser!.uid,
    });

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}
// look at ? mark at <User?> delete if code does not work

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        //look at ? at User? delete if code does not work
        email: email,
        password: password);

    print("Login Successful");
    _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((value) => userCredential.user!.updateDisplayName(value['name']));

    return userCredential.user;
  } catch (e) {
    print(e);
    return null;
  }
}
//Fix this when you have Login Screen Ready

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => MyLogin())); // Edit Later for LoginScreen
    });
  } catch (e) {
    print("error");
  }
}
