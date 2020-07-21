import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helpers/scrabble_helper.dart';
import '../providers/scrabble_dictionary.dart';

class DictionaryCheckWidget extends StatelessWidget {
  DictionaryCheckWidget(this.chars, {key}) : super(key: key);

  final List<String> chars;

  Future<void> launchDictionary() async {
    final word = chars
        .where((element) => ScrabbleHelper.LETTERS.containsKey(element))
        .join("")
        .toLowerCase();
    final url = 'https://sjp.pl/$word';
    if (await canLaunch(url))
      await launch(url);
    else
      print('Could not launch $url');
  }

  @override
  Widget build(BuildContext context) {
    var dictionary = Provider.of<ScrabbleDictionary>(context);
    if (!dictionary.isReady) return const LoadingChip("Ładowanie słownika");
    return GestureDetector(
      onTap: launchDictionary,
      child: FutureBuilder(
          future: dictionary.isApproved(chars),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return const LoadingChip("Sprawdzanie w słowniku");
            if (snapshot.hasError) {
              print(snapshot.error);
              return const ErrorChip();
            } else if (snapshot.data)
              return const ApprovedChip();
            else
              return const NotApprovedChip();
          }),
    );
  }
}

class NotApprovedChip extends StatelessWidget {
  const NotApprovedChip({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: const Color.fromRGBO(217, 83, 79, 1),
      label: const Text(
        "Słowo niedozwolone",
        style: TextStyle(color: Colors.white),
      ),
      avatar: const Icon(
        Icons.close,
        color: Colors.white,
      ),
    );
  }
}

class LoadingChip extends StatelessWidget {
  const LoadingChip(this.label);
  final String label;
  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: const Color.fromRGBO(240, 173, 78, 1),
      label: Text(
        label,
        style: TextStyle(color: Colors.white),
      ),
      avatar: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )),
        ],
      ),
    );
  }
}

class ApprovedChip extends StatelessWidget {
  const ApprovedChip({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
        backgroundColor: const Color.fromRGBO(92, 184, 92, 1),
        label: const Text(
          "Słowo dozwolone",
          style: TextStyle(color: Colors.white),
        ),
        avatar: const Icon(
          Icons.check,
          color: Colors.white,
        ));
  }
}

class ErrorChip extends StatelessWidget {
  const ErrorChip({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: const Color.fromRGBO(217, 83, 79, 1),
      label: const Text(
        "Błąd słownika",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
