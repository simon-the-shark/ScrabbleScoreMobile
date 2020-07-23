import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DictionarySourcesInfoPopup extends StatelessWidget {
  const DictionarySourcesInfoPopup();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Słownik scrabble"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              "Słownik jest opcjonalną funkcją aplikacji, dzięki której dostajesz informacje o dopuszczalności wyrazów. Najlepszą wydajność, niezawodność i niezależność zapewnia pobranie lokalnego słownika, lecz w przypadku braku tej możliwości, można skorzystać ze słownika online, który sprawdza pojedyncze słowa w internecie."),
          const SizedBox(height: 5),
          RichText(
            textScaleFactor: 1.15,
            text: TextSpan(
              style: Theme.of(context).textTheme.bodyText2,
              text: "Baza wyrazów pochodzi ze strony ",
              children: [
                TextSpan(
                  text: 'sjp.pl',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch("https://sjp.pl/slownik/growy/");
                    },
                ),
                const TextSpan(text: " z dnia 23.07.2020 r."),
              ],
            ),
          ),
        ],
      ),
      actions: [
        FlatButton(
          child: const Text("OK"),
          onPressed: Navigator.of(context).pop,
        )
      ],
    );
  }
}
