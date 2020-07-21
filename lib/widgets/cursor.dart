import 'dart:async';

import 'package:flutter/material.dart';

class Cursor extends StatefulWidget {
  const Cursor({this.color, this.height, key}) : super(key: key);
  final Color color;
  final double height;

  @override
  CursorState createState() => CursorState();
}

class CursorState extends State<Cursor> {
  Timer t;
  Timer typingTimer;
  bool show = true;
  bool isTypying = false;
  @override
  void initState() {
    t = Timer.periodic(
        Duration(milliseconds: 500),
        (t) => setState(() {
              show = !show;
            }));
    super.initState();
  }

  @override
  void dispose() {
    t.cancel();
    typingTimer?.cancel();
    super.dispose();
  }

  void startTypying() {
    typingTimer?.cancel();
    setState(() {
      isTypying = true;
    });
    typingTimer = Timer(Duration(milliseconds: 500), stopTypying);
  }

  void stopTypying() => setState(() {
        isTypying = false;
      });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: (isTypying || show) ? 1 : 0,
      child: Container(
        width: 1,
        height: widget.height,
        color: widget.color,
      ),
    );
  }
}
