// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:dio/dio.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'dart:convert';

// class Feed extends StatefulWidget {
//   @override
//   _FeedState createState() => _FeedState();
// }

// class _FeedState extends State<Feed> {
//   // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);

  // void _onRefresh() async {
  //   // monitor network fetch
  //   await Future.delayed(Duration(milliseconds: 1000));

  //   List<dynamic> _feedNews = [];
  //   // if failed,use refreshFailed()
  //   Response response =
  //       await Dio().get('https://resident12.herokuapp.com/posts/allposts');
  //   setState(() {
  //     print(json.decode(response.data));
  //   });
  //   _refreshController.refreshCompleted();
  // }

  // void _onLoading() async {
  //   // monitor network fetch
  //   await Future.delayed(Duration(milliseconds: 1000));
  //   // if failed,use loadFailed(),if no data return,use LoadNodata()

  //   if (mounted) setState(() {});
  //   _refreshController.loadComplete();
  // }

//   @override
//   Widget build(BuildContext context) {
//     return RefreshIndicator(
//       child: ListView(
//         children
//       )
//     )
//   }
// }
// }
