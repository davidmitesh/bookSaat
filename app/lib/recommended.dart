import 'package:flutter/material.dart';
import 'package:nothotdog/loading_list.dart';
import 'package:nothotdog/models/loading.dart';
import 'package:nothotdog/viewmodels/recommended.dart';
import 'package:provider/provider.dart';
import 'bookList.dart';

class RecommendedBooks extends StatefulWidget {
  @override
  _RecommendedBooksState createState() => _RecommendedBooksState();
}

class _RecommendedBooksState extends State<RecommendedBooks> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<RecommendedState>(context);
    final books = state.getBooks();
    return state.getState() == loadingState.IS_LOADING
        ? CustomLoadingList()
        : BooksList(
            books: books,
            title: 'Recommended',
          );
  }
}
