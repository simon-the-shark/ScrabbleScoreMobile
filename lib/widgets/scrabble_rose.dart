import 'package:flutter/material.dart';

class ScrabbleRose extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var side = MediaQuery.of(context).size.width / 3;
    return Container(
      height: side - 5,
      width: side - 5,
      color: Colors.red[100],
      child: Image.asset("assets/wind-rose.png"),
    );
  }
}
