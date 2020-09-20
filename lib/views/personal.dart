import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import '../models/feed.dart';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../auth.dart';
import 'login.dart';
import 'post.dart';
import 'form.dart';
import '../main.dart';

class PersonalPage extends StatefulWidget {
  @override
  _PersonalPageState createState() => _PersonalPageState();
}

class _PersonalPageState extends State<PersonalPage> {
  SharedPreferences sharedPreferences;
  Widget x;

  @override
  void initState() {
    checkFeed();
    super.initState();

    print(feeds.length);
  }

  var feeds = List<Feed>();
  checkFeed() async {
    var response = await http.get(
      "https://resident12.herokuapp.com/posts/myposts",
    );
    Iterable jsonResponse = json.decode(response.body);
    feeds = jsonResponse.map((model) => Feed.fromJson(model)).toList();
    print(1);
  }

  getFeed() async {
     var preferences = await SharedPreferences.getInstance();
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    var token1 = preferences.getString('token');
    var response = await http.get(
      "https://resident12.herokuapp.com/posts/myposts",headers:{ 
              "x-auth-token": token1,}
            );
    
    Iterable jsonResponse = json.decode(response.body);
    feeds = jsonResponse.map((model) => Feed.fromJson(model)).toList();
    print(feeds[0].title);
    setState(() {
      y = feeds;
    });
  }

  List<Feed> y = [];
  Color a = Colors.black;
  Color b = Colors.black;
  Color c = Colors.black;

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
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.builder(
              itemCount: feeds.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Color(0xff353b48),
                  child: feeds.length == 0
                      ? Container()
                      : ListTile(
                          trailing: IconButton(
                              icon: Icon(Icons.open_in_new),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PostPage(
                                            data: feeds[index],
                                          )),
                                );
                              }),
                          title: Container(
                              padding: EdgeInsets.symmetric(vertical: 20.0),
                              child: Text(feeds[index].title,
                                  style: GoogleFonts.asap(
                                    textStyle: TextStyle(
                                        color: Colors.white, fontSize: 20.0),
                                  ))),
                          subtitle: Container(
                              margin: EdgeInsets.only(top: 30.0),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.arrow_upward),
                                    color: a,
                                    onPressed: () async {
                                      // var response = await http.get(
                                      //   "https://resident12.herokuapp.com/posts/upvote/${feeds[index].id}",
                                      // );
                                      if (a == Colors.black) {
                                        setState(() {
                                          a = Colors.grey;
                                        });
                                      } else {
                                        setState(() {
                                          a = Colors.black;
                                        });
                                      }
                                    },
                                  ),
                                  IconButton(
                                    color: b,
                                    icon: Icon(Icons.arrow_downward),
                                    onPressed: () async {
                                      // print(feeds[index].id);
                                      // var response = await http.get(
                                      //   "https://resident12.herokuapp.com/posts/downvote/${feeds[index].id}",
                                      // );
                                      if (b == Colors.black) {
                                        setState(() {
                                          b = Colors.grey;
                                        });
                                      } else {
                                        setState(() {
                                          b = Colors.black;
                                        });
                                      }
                                    },
                                  ),
                                  IconButton(
                                    color: c,
                                    icon: Icon(Icons.flag),
                                    onPressed: () async {
                                      // var response = await http.get(
                                      //   "https://resident12.herokuapp.com/posts/flag/${feeds[index].id}",
                                      // );
                                      if (c == Colors.black) {
                                        setState(() {
                                          c = Colors.grey;
                                        });
                                      } else {
                                        setState(() {
                                          c = Colors.black;
                                        });
                                      }
                                    },
                                  )
                                ],
                              ))),
                );
              },
            )),
      ),
      bottomNavigationBar: new BottomAppBar(
        color: Color(0xff222423),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => MainPage()));
              },
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
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => PersonalPage()));
              },
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
