import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/login.dart';
import 'views/profile.dart';
import 'auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:convert';
import 'views/form.dart';
import 'views/feed.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'models/feed.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resident',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  SharedPreferences sharedPreferences;
  Widget x;
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
    checkFeed();
    print(feeds.length);
  }

  var feeds = List<Feed>();
  checkFeed() async {
    var response = await http.get(
      "https://resident12.herokuapp.com/posts/allposts",
    );
    Iterable jsonResponse = json.decode(response.body);
    feeds = jsonResponse.map((model) => Feed.fromJson(model)).toList();
  }

  getFeed() async {
    var response = await http.get(
      "https://resident12.herokuapp.com/posts/allposts",
    );
    Iterable jsonResponse = json.decode(response.body);
    feeds = jsonResponse.map((model) => Feed.fromJson(model)).toList();
    print(feeds[0].title);
    setState(() {
      y = feeds;
    });
  }

  List<Feed> y = [];

  checkLoginStatus() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString('token') == null) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => LoginPage()),
          (Route<dynamic> route) => false);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Resident"),
        backgroundColor: Color(0xFF2F3640),
        elevation: 5.0,
        shadowColor: Colors.black,
        iconTheme: new IconThemeData(color: Colors.green),
        textTheme: new TextTheme(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () => signOutGoogle().whenComplete(() => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (BuildContext context) => LoginPage()),
                        (Route<dynamic> route) => false)
                  }))
          //  => signOutGoogle().whenComplete(() =>
          //
        ],
      ),
      body: Container(
          margin: EdgeInsets.only(top: 15.0),
          color: Color(0xFF2F3640),
          child: ListView.builder(
            itemCount: y.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text(y[index].title),
                ),
              );
            },
          )),
      bottomNavigationBar: new BottomAppBar(
        color: Color(0xff222423),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              color: Colors.blue,
              icon: Icon(Icons.new_releases),
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => FormPage()));
              },
              color: Colors.blue,
              icon: Icon(Icons.add_box),
            ),
            IconButton(
              color: Colors.blue,
              onPressed: () {},
              icon: Icon(Icons.folder),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {getFeed()},
        child: new Icon(Icons.refresh),
        backgroundColor: Colors.green,
      ),
    );
  }
}
