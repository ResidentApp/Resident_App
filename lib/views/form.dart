import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import 'package:intl/intl.dart';

var x;

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final taskName = TextEditingController();
  final desc = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void initState() {
    
    super.initState();
  }

  File _imageFile;
  func() {
    return;
  }
  String msg = "";
  postCreation() async {
    var preferences = await SharedPreferences.getInstance();
    StorageReference ref =
        FirebaseStorage.instance.ref().child(x.toString() + '.png');
    var url = await ref.getDownloadURL();
    var token1 = preferences.getString('token');
    // print(token1);
    // print(url);
    var y = DateTime.now();

    print(preferences.getString('uploadTime'));
    var prevUpload = DateTime.parse(preferences.getString('uploadTime'));
    preferences.setString('uploadTime', (DateTime.now()).toString());
    if (prevUpload != null) {
      var diff = y.difference(prevUpload);
      print(diff.inMinutes);
      if (diff.inMinutes <= 15) {
        setState(() {
          msg = "To avoid spam app allows user to post only once in 15 mins...";
        });

        return;
      }
    }

    // final ref = FirebaseStorage.instance.ref().child(x);
    // var url = await ref.getDownloadURL();
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);
    final task = {
      "title": taskName.text,
      "description": desc.text,
      "imgURL": url.toString(),
      "location": {
        "coordinates": [position.latitude, position.longitude]
      },
    };
    Response response =
        await Dio().post("https://resident12.herokuapp.com/posts/createPost",
            data: task,
            options: Options(headers: {
              "x-auth-token": token1,
            }));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => MainPage()),
        (Route<dynamic> route) => false);
  }

  /// Select an image via gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    File selected = await ImagePicker.pickImage(source: source);

    setState(() {
      _imageFile = selected;
    });
  }

  /// Remove image
  void _clear() {
    setState(() => _imageFile = null);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.green),
        ),
        body: Container(
          color: Color(0xFF2F3640),
          child: ListView(
            children: <Widget>[
              if (_imageFile != null) ...[
                Image.file(_imageFile),
                Row(
                  children: <Widget>[
                    FlatButton(
                      child: Icon(Icons.refresh),
                      onPressed: _clear,
                    ),
                  ],
                ),
                Uploader(file: _imageFile),
              ],
              Container(
                width: 300,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        cursorColor: Colors.white,
                        style: GoogleFonts.asap(
                            textStyle: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        decoration: const InputDecoration(
                            hintText: 'Title',
                            hintStyle: TextStyle(color: Color(0xff7f8c8d))),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: taskName,
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        style: GoogleFonts.asap(
                            textStyle:
                                TextStyle(fontSize: 16.0, color: Colors.white)),
                        decoration: const InputDecoration(
                          hintText: 'Post description',
                          hintStyle: TextStyle(color: Color(0xff7f8c8d)),
                          //fillColor: Colors.green
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                        controller: desc,
                      ),
                      SizedBox(height: 50.0),
                      Center(
                          child: Text('Add Image',
                              style: GoogleFonts.asap(
                                  textStyle: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xff7f8c8d),
                                      fontWeight: FontWeight.bold)))),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 30.0,
                            child: IconButton(
                              icon: Icon(Icons.photo_camera),
                              onPressed: () => _pickImage(ImageSource.camera),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 30.0,
                            child: IconButton(
                              icon: Icon(Icons.photo_library),
                              onPressed: () => _pickImage(ImageSource.gallery),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20),
                        child: RaisedButton(
                          color: Color(0xFFCED6E0),
                          onPressed: () {
                            postCreation();
                          },
                          child: Text(
                            'Submit',
                            style:
                                TextStyle(fontSize: 15.0, letterSpacing: 1.5),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(3.0)),
                        ),
                      ),
                      Center(child:Text(msg,style: TextStyle(color: Colors.red),))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

class Uploader extends StatefulWidget {
  final File file;
  Uploader({Key key, this.file}) : super(key: key);
  @override
  createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://resident-app-289706.appspot.com');

  StorageUploadTask _uploadTask;

  /// Starts an upload task
  void _startUpload() async {
    /// Unique file name for the file
    ///
    final sharedPreferences = await SharedPreferences.getInstance();

    x = DateTime.now();

    sharedPreferences.setString('uploadTime', x.toString());
    String filePath = '${x}.png';

    setState(() {
      _uploadTask = _storage.ref().child(filePath).putFile(widget.file);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      /// Manage the task state and event subscription with a StreamBuilder
      return StreamBuilder<StorageTaskEvent>(
          stream: _uploadTask.events,
          builder: (_, snapshot) {
            var event = snapshot?.data?.snapshot;

            double progressPercent = event != null
                ? event.bytesTransferred / event.totalByteCount
                : 0;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_uploadTask.isComplete) Text('🎉🎉🎉'),

                if (_uploadTask.isPaused)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),

                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),

                // Progress bar
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)} % '),
              ],
            );
          });
    } else {
      // Allows user to decide when to start the upload
      return FlatButton.icon(
        label: Text('Upload to Firebase'),
        icon: Icon(Icons.cloud_upload),
        onPressed: _startUpload,
      );
    }
  }
}
