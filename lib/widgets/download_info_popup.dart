import 'package:flutter/material.dart';

class DowloadInfoPopup extends StatelessWidget {
  const DowloadInfoPopup();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Pobieranie słownika"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            textScaleFactor: 1.3,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText2,
              text: "Do pobrania: ",
              children: [
                const TextSpan(
                    text: '45,6 MB',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          RichText(
            textScaleFactor: 1.3,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText2,
              text: "Po wypakowaniu: ~",
              children: [
                const TextSpan(
                    text: '135 MB',
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          RichText(
            textScaleFactor: 1.3,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText2,
              text: "Wymagana wolna pamięć:",
            ),
          ),
          RichText(
            textScaleFactor: 1.3,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText2,
              text: "~",
              children: [
                const TextSpan(
                  text: '180 MB',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: const Text("Anuluj"),
          onPressed: Navigator.of(context).pop,
        ),
        FlatButton(
          child: const Text("Pobierz"),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }
}
