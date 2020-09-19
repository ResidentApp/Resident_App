import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'dart:convert';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'signup.dart';
import '../auth.dart';
import 'package:dio/dio.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class PermissionService {
  Future<bool> _requestPermission() async {
    if (await Permission.location.request().isGranted) {
      return true;
    }
    return false;
  }

  Future<bool> requestPermission({Function onPermissionDenied}) async {
    var granted = await _requestPermission();
    if (!granted) {
      onPermissionDenied();
    }
    return granted;
  }

  Future<bool> hasPhonePermission() async {
    return hasPermission(Permission.phone);
  }

  Future<bool> hasPermission(Permission permission) async {
    var permissionStatus = await Permission.location.status;

    return permissionStatus == PermissionStatus.granted;
  }
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool _isLoggedIn = false;
  bool _isLoading = false;

  @override
  initState() {
    permissionAcessPhone();
    super.initState();
  }

  Future permissionAcessPhone() {
    PermissionService().requestPermission(onPermissionDenied: () {
      print('Permission has been denied');
    });
  }

  signIn(String email, String pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var jsonResponse = null;

    var response = await Dio().post(
      'https://residentapp.herokuapp.com/signin',
      data: {'email': email, 'password': pass},
    );
    jsonResponse = json.decode(response.data);
    if (jsonResponse != null) {
      setState(() {
        _isLoading = false;
      });
      sharedPreferences.setString("token", jsonResponse['token']);
    } else {
      setState(() {
        _isLoading = false;
      });
      print(response.data);
    }
  }

  // Container logoSection() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: 50.0,
  //       padding: EdgeInsets.symmetric(horizontal: 20.0),
  //       margin: EdgeInsets.only(top: 10.0),
  //       child: Image.asset("images/appstore.png",scale: 1.0,)
  //   );
  // }
  Container buttonSection() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RaisedButton(
                onPressed: emailController.text == "" ||
                        passwordController.text == ""
                    ? null
                    : () {
                        setState(() {
                          _isLoading = true;
                        });
                        signIn(emailController.text, passwordController.text)
                            .whenCompleted(() => {
                                  setState(() => {_isLoading = false}),
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              MainPage()),
                                      (Route<dynamic> route) => false)
                                });
                      },
                color: Color(0xFFFFC957),
                child: Text('Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 1.5)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0))),
            SignInButton(Buttons.Google, onPressed: () {
              signInWithGoogle().whenComplete(() => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => MainPage()),
                        (Route<dynamic> route) => false)
                  });
            }),
            RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => SignUpPage()),
                      (Route<dynamic> route) => false);
                },
                color: Colors.white,
                child: Text('Sign up',
                    style: TextStyle(color: Color(0xff535c68), fontSize: 14.0)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0))),
          ],
        ));
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          TextField(
            controller: emailController,
            cursorColor: Colors.white,
            style: GoogleFonts.asap(textStyle: TextStyle(color: Colors.white)),
            decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Color(0xff7f8c8d))),
          ),
          SizedBox(height: 30.0),
          TextField(
            controller: passwordController,
            cursorColor: Colors.white,
            style: GoogleFonts.asap(textStyle: TextStyle(color: Colors.white)),
            decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Color(0xff7f8c8d))),
          ),
        ],
      ),
    );
  }

  Container heardSection() {
    return Container(
        margin: EdgeInsets.only(top: 150.0),
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Sign in",
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                textAlign: TextAlign.left),
            Text(
              "Hi there! Nice to see you again",
              style: GoogleFonts.asap(
                textStyle: TextStyle(color: Color(0xff95a5a6), fontSize: 18.0),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Color(0xFF2F3640),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    // logoSection(),
                    heardSection(),
                    textSection(),
                    buttonSection()
                  ],
                )),
    );
  }
}
