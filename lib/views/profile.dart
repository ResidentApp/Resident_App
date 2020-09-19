import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("Bois Dance"),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: Colors.green),
          textTheme: new TextTheme(),
          
        ),
        drawer: Drawer(
          
          child: Container(
            color: Color(0xff252d38),
              child: ListView(
              
              children: [
                new DrawerHeader(
                    child: new CircleAvatar(
                      backgroundColor: Colors.purple[900],
                      radius: 100,
                      
                    )),
                    
                new ListTile(
                  title: Text("Feed",style: GoogleFonts.asap(textStyle: TextStyle(color: Color(0xffbdc3c7),fontWeight: FontWeight.bold)),),
                  trailing: Icon(Icons.arrow_back),
                  onTap: () => {
                      Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (BuildContext context) => MainPage()),
                      (Route<dynamic> route) => false)
                  },
                ),
                new ListTile(
                  title: Text("My Posts",style: GoogleFonts.asap(textStyle: TextStyle(color: Color(0xffbdc3c7),fontWeight: FontWeight.bold)),),
                  trailing: Icon(Icons.arrow_back),
                  onTap: () => {},
                ),
                new ListTile(
                  title: Text("Settings",style: GoogleFonts.asap(textStyle: TextStyle(color: Color(0xffbdc3c7),fontWeight: FontWeight.bold)),),
                  trailing: Icon(Icons.arrow_back),
                  onTap: () => {
                      Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (BuildContext context) => Profile()),
                      (Route<dynamic> route) => false)
                  },
                ),
                
                
              ],
            ),
          )
        ),
        body: Container(
          color: Color(0xFF2F3640),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 100),
              new Container(
                    width: 190.0,
                    height: 190.0,
                    decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://i.imgur.com/BoN9kdC.png")
                        )
                    )),
              SizedBox(height: 50),
              Text('Nisarg Bijutkar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'open sans',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      color: Color(0xffbdc3c7))),
              SizedBox(height: 10),
              Text('Full Stack Developer',
                  textAlign: TextAlign.center, style: GoogleFonts.asap(textStyle:TextStyle(fontSize: 15,color: Color(0xff7f8c8d)))),
              Text('',
                  textAlign: TextAlign.center, style: GoogleFonts.asap(textStyle:TextStyle(fontSize: 15,color: Color(0xff7f8c8d))))
            ],
            
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: new Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        );
  }
}