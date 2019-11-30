import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nothotdog/models/book.dart';
import 'package:nothotdog/models/loading.dart';
import 'package:http/http.dart' as http;

class SearchState with ChangeNotifier {
  loadingState dataState;
  String queryString;
  List<Book> books;
  final String url = 'http://10.10.10.153:8080/search?q=';

  SearchState(this.dataState, this.books, this.queryString) {
    fetchData();
  }

  getState() => loadingState;
  getBooks() => books;

  setdataState(loadingState value) {
    dataState = value;
    notifyListeners();
  }

  fetchData() async {
    setdataState(loadingState.IS_LOADING);
    http.get(url + queryString).then((response) {
      json.decode(response.body);
      if (response.statusCode == 200) {
        books = (json.decode(response.body) as List)
            .map((data) => Book.fromJson(data))
            .toList();
        setdataState(loadingState.IS_LOADED);
      } else {
        setdataState(loadingState.ERROR_OCCURED);
      }
    });
  }
}
