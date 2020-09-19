import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();


Future<String> signInWithGoogle() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  var body = json.encode({
    "googleID": _googleSignIn.currentUser.id,
    "username": _googleSignIn.currentUser.displayName,
    "email": _googleSignIn.currentUser.email
  });
  var response = await http.post(
      "https://resident12.herokuapp.com/googlesignup",
      body: body,
      );
  var jsonResponse = json.decode(response.body);
  sharedPreferences.setString("token", jsonResponse['token']);
  print(jsonResponse['token']);
  return 'signInWithGoogle succeeded';
}

Future<bool> signOutGoogle() async {
  await _googleSignIn.signOut();

  print("User Sign Out");
  return Future.value(true);
}
