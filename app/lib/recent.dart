import 'package:flutter/material.dart';
import 'package:nothotdog/loading_list.dart';
import 'package:nothotdog/models/loading.dart';

class RecentlyViewedBooks extends StatefulWidget {
  @override
  _RecentlyViewedBooksState createState() => _RecentlyViewedBooksState();
}

class _RecentlyViewedBooksState extends State<RecentlyViewedBooks> {
  loadingState dataLoadingState = loadingState.IS_LOADING;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await Future.delayed(Duration(seconds: 3));
    setState(() {
      dataLoadingState = loadingState.IS_LOADED;
    });
  }

  @override
  Widget build(BuildContext context) {
    return dataLoadingState == loadingState.IS_LOADING
        ? CustomLoadingList()
        : Container();
  }
}
