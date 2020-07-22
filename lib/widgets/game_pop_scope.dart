import 'package:flutter/material.dart';

class GamePopScope extends StatelessWidget {
  GamePopScope({this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () async {
        var confirmation = await showDialog(
          context: context,
          child: AlertDialog(
            title: const Text("Przerwać rozgrywkę?"),
            content: const Text(
                "Czy chcesz wyjść? Wyjście oznacza przerwanie rozgrywki, którą można następnie wznowić."),
            actions: <Widget>[
              FlatButton(
                child: const Text("Wyjdź"),
                onPressed: () => Navigator.of(context).pop(true),
              ),
              FlatButton(
                child: const Text("Gramy dalej!"),
                onPressed: () => Navigator.of(context).pop(false),
              )
            ],
          ),
        );
        return confirmation == true;
      },
    );
  }
}
