import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import '../models/feed.dart';
import 'package:photo_view/photo_view.dart';

class PostPage extends StatelessWidget {
  final Feed data;
  PostPage({this.data});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff353b48),
        iconTheme: IconThemeData(color: Colors.blue[600]),
      ),
      body: Container(
        color: Color(0xff353b48),
        padding: EdgeInsets.all(12.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Image.network(data.imgURL),
            Container(
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              height: 150.0,
                child: PhotoView(
                  imageProvider: NetworkImage(data.imgURL),
                  minScale: PhotoViewComputedScale.contained * 0.3,
                  maxScale: PhotoViewComputedScale.covered * 2.2,
                )
              ),
            Container(
              color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 100.0,
                child: Container(padding: EdgeInsets.symmetric(horizontal:20.0,vertical:20.0),child:Text(data.title,
                    style: GoogleFonts.asap(textStyle: TextStyle(fontWeight: FontWeight.w700,fontSize: 24.0))),)),
            
            Container(
              color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: 150.0,
            child:Container(padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20.0),child:Text(data.description,style: GoogleFonts.asap(
              textStyle: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold)
            ),)),
            )
          ],
        ),
      ),
    );
  }
}
