import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mlkit/mlkit.dart';
import 'models/book.dart';
import 'models/loading.dart';
import 'bookList.dart';
import 'loading_list.dart';
import 'package:http/http.dart' as http;

class DetectorScreen extends StatefulWidget {
  final File image;

  DetectorScreen({Key key, this.image}) : super(key: key);
  @override
  _DetectorScreenState createState() => _DetectorScreenState();
}

class _DetectorScreenState extends State<DetectorScreen> {
  // List<VisionText> _currentLabels = <VisionText>[];
  List<Book> books;
  FirebaseVisionTextDetector detector = FirebaseVisionTextDetector.instance;
  loadingState dataState = loadingState.IS_LOADING;

  @override
  void initState() {
    super.initState();
    detectImage();
  }

  void detectImage() async {
    try {
      List<VisionText> currentLabels =
          await detector.detectFromPath(widget.image?.path);

      String data = currentLabels.map((item) => item.text).toList().toString();
      fetchData('stephen');
    } catch (e) {
      print(e.toString());
    }
  }

  fetchData(String query) async {
    setState(() {
      dataState = loadingState.IS_LOADING;
    });
    http.get('http://10.10.10.153:8080/exchange?q=$query').then((response) {
      json.decode(response.body);
      if (response.statusCode == 200) {
        books = (json.decode(response.body) as List)
            .map((data) => Book.fromJson(data))
            .toList();
        setState(() {
          dataState = loadingState.IS_LOADED;
        });
      } else {
        setState(() {
          dataState = loadingState.ERROR_OCCURED;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Center(
              child: SizedBox(
                width: 200,
                height: 300,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)),
                  elevation: 8.0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                          image: FileImage(widget.image), fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
            ),
          ),
          dataState == loadingState.IS_LOADING
              ? CustomLoadingList()
              : BooksList(
                  books: books,
                  title: 'Recommended',
                )
        ],
      ),
    );
  }

  Widget loadingWidget() {
    return Container(
      color: Colors.black38,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
          Text(
            'Evaluating...',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ],
      ),
    );
  }
}
