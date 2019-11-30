import 'package:flutter/material.dart';

class TitleWithButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  TitleWithButton({Key key, this.title = 'Title', this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        FlatButton(
          padding: const EdgeInsets.all(0.0),
          child: Text(
            'View all',
            style: TextStyle(color: Colors.blue),
          ),
          onPressed: onTap,
        )
      ],
    );
  }
}
