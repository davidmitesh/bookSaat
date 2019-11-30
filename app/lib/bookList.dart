import 'package:flutter/material.dart';
import 'package:nothotdog/detail.dart';
import 'package:nothotdog/title_with_button.dart';

import 'models/book.dart';

class BooksList extends StatelessWidget {
  final List<Book> books;
  final String title;

  BooksList({Key key, this.books, this.title = 'title'}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TitleWithButton(
          title: title,
          onTap: () {},
        ),
        books == null ? Text('Empty') : booksList(books),
      ],
    );
  }

  Widget booksList(List<Book> bookList) => SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bookList.length,
          itemBuilder: (context, index) => createTile(bookList[index], context),
        ),
      );

  ///create book tile hero
  Widget createTile(Book book, BuildContext context) => Hero(
        tag: '$title:${book.title}',
        child: Material(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BookDetail(
                              book: book,
                              herotag: '$title:${book.title}',
                            )));
              },
              child: Container(
                width: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)),
                          elevation: 8.0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(book.imgUrl),
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        book.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      book.author.authName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
