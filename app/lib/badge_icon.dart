import 'package:flutter/material.dart';

class NotifbadgeIcon extends StatelessWidget {
  final IconData icon;
  final int count;

  NotifbadgeIcon({Key key, this.icon = Icons.notifications, this.count = 10})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        IconButton(
            icon: Icon(
              icon,
              color: Colors.black,
            ),
            onPressed: () {}),
        Positioned(
          right: 10,
          top: 12,
          child: Container(
            padding: EdgeInsets.all(2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            constraints: BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }
}
