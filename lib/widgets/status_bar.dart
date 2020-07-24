import 'package:flutter/material.dart';

class StatusBar extends StatelessWidget {
  const StatusBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).padding.top,
        color: Colors.teal[500],
      ),
    );
  }
}
