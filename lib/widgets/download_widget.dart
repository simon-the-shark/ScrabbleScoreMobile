import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../providers/scrabble_dictionary.dart';

class DownloadWidget extends StatefulWidget {
  DownloadWidget(this.isDowloading);
  bool isDowloading;
  @override
  _DownloadWidgetState createState() => _DownloadWidgetState();
}

class _DownloadWidgetState extends State<DownloadWidget> {
  double progress = 0;

  @override
  void initState() {
    Provider.of<ScrabbleDictionary>(context, listen: false)
        .downloadAndUnzip((val) {
      if (!mounted) return;
      setState(() {
        progress = val;
      });
    }).then((_) {
      widget.isDowloading = false;
      Provider.of<ScrabbleDictionary>(context, listen: false)
          .setSource(DictionarySources.local);
      OverlaySupportEntry.of(context).dismiss();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          color: Colors.black45,
          child: AlertDialog(
            title: progress < 100
                ? const Text("Pobieranie")
                : const Text("Odpakowywanie"),
            content: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 220),
              child: Stack(
                children: [
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator(),
                        ),
                        const SizedBox(height: 30),
                        if (!ScrabbleDictionary.isUnpacked && progress < 100)
                          Text(
                            "${progress.toStringAsFixed(0)} %",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        const SizedBox(height: 30),
                        if (!ScrabbleDictionary.isUnpacked && progress < 100)
                          Text(
                            "W przypadku zamknięcia aplikacji, postęp pobierania zostanie utracony",
                            softWrap: true,
                            style: Theme.of(context).textTheme.caption,
                          ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: LinearProgressIndicator(
                      value: progress / 100,
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
