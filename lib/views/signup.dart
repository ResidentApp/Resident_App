import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'dart:convert';
import '../main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'login.dart';
import 'dart:io';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController nameController = new TextEditingController();
  final TextEditingController usernameController = new TextEditingController();

  bool _isLoading = false;

  signUp(String name, String username, String email, String password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    print(name);
    print(username);
    print(email);
    print(password);
    var jsonResponse = null;
    var body = json.encode({
      "name": name,
      "username": username,
      "email": email,
      "password": password
    });
    Response response = await Dio().post(
        "https://resident12.herokuapp.com/signup",
        data: body,
        options: Options(
            headers: {"accept": "*/*", "content-type": "application/json"}));

    setState(() {
      _isLoading = false;
    });
    sharedPreferences.setString("token", jsonResponse['token']);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
        (Route<dynamic> route) => false);
  }

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
                onPressed:
                    emailController.text == "" || passwordController.text == ""
                        ? null
                        : () => {
                              setState(() => {_isLoading = true}),
                              signUp(
                                  nameController.text.toString(),
                                  usernameController.text.toString(),
                                  emailController.text.toString(),
                                  passwordController.text.toString())
                            },
                color: Color(0xFFFFC957),
                child: Text('Submit',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 1.5)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0))),
            SignInButton(
              Buttons.Google,
              onPressed: () {},
            ),
          ],
        ));
  }

  Container textSection() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          TextField(
            controller: nameController,
            cursorColor: Colors.white,
            style: GoogleFonts.asap(textStyle: TextStyle(color: Colors.white)),
            decoration: InputDecoration(
                hintText: "Name",
                hintStyle: TextStyle(color: Color(0xff7f8c8d))),
          ),
          TextField(
            controller: usernameController,
            cursorColor: Colors.white,
            style: GoogleFonts.asap(textStyle: TextStyle(color: Colors.white)),
            decoration: InputDecoration(
                hintText: "Username",
                hintStyle: TextStyle(color: Color(0xff7f8c8d))),
          ),
          TextField(
            controller: emailController,
            cursorColor: Colors.white,
            style: GoogleFonts.asap(textStyle: TextStyle(color: Colors.white)),
            decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Color(0xff7f8c8d))),
          ),
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
            Text("Sign Up",
                style: GoogleFonts.quicksand(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
                textAlign: TextAlign.left),
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
                  children: [heardSection(), textSection(), buttonSection()],
                )),
    );
  }
}
