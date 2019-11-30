import 'package:flutter/material.dart';
import 'package:nothotdog/viewmodels/searchState.dart';
import 'package:provider/provider.dart';
import 'bookList.dart';
import 'loading_list.dart';
import 'models/loading.dart';

class SearchPage extends StatefulWidget {
  final String searchTerm;

  SearchPage({Key key, @required this.searchTerm}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<SearchState>(context);
    final books = state.getBooks();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Results for ${widget.searchTerm}',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Seems like the exact match couldn't be found. Here are some recommendations.",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            state.getState() == loadingState.IS_LOADING
                ? CustomLoadingList()
                : BooksList(
                    books: books,
                    title: 'Recommended',
                  )
          ],
        ),
      ),
    );
  }
}
