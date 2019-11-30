import 'package:flutter/material.dart';
import 'package:nothotdog/title_with_button.dart';

import 'models/book.dart';

List<String> names = [
  'Bibek Timsina',
  'Alex Bhattarai',
  'Mitesh Pandey',
  'Elon Musk'
];

class BookDetail extends StatelessWidget {
  final Book book;
  final String herotag;

  BookDetail({this.book, this.herotag});

  @override
  Widget build(BuildContext context) {
    //app bar
    final appBar = AppBar(
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        book.title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: ListView(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: SizedBox(
                height: 220,
                width: 150,
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    book.author.authName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            TitleWithButton(
              title: 'Ready to exchange',
              onTap: () {},
            ),
            ListView.builder(
              itemCount: names.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Card(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Text(
                    names[index],
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  trailing: FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Exchange',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  ///create text widget
  text(String data,
          {Color color = Colors.black87,
          num size = 14,
          EdgeInsetsGeometry padding = EdgeInsets.zero,
          bool isBold = false}) =>
      Padding(
        padding: padding,
        child: Text(
          data,
          style: TextStyle(
              color: color,
              fontSize: size.toDouble(),
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
        ),
      );
}
