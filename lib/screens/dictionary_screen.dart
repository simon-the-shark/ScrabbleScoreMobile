import 'dart:ui';

import 'package:app/widgets/download_widget.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../providers/scrabble_dictionary.dart';
import '../widgets/dictionary_sources_info_popup.dart';
import '../widgets/download_info_popup.dart';
import 'game_menu_screen.dart';

class DictionaryScreen extends StatelessWidget {
  static const routeName = "/dictionary-source";
  bool isDownloading = false;
  void download(BuildContext context) async {
    var confirmation =
        await showDialog(context: context, child: const DowloadInfoPopup());
    if (confirmation != true) return;
    isDownloading = true;
    showOverlay((context, t) {
      return Opacity(
        opacity: t,
        child: DownloadWidget(isDownloading),
      );
    }, duration: Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ScrabbleDictionary>(context);
    var appBar = AppBar(
      title: const Text("Źródło słownika"),
    );
    return WillPopScope(
      onWillPop: () async => !isDownloading,
      child: Scaffold(
        appBar: appBar,
        body: provider.isReady
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top -
                            appBar.preferredSize.height -
                            40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Wybierz źródło słownika słów dopuszczonych do gier scrabble, literaki itd.",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(height: 15),
                            for (var source in DictionarySources.values)
                              Row(
                                children: [
                                  if (source != DictionarySources.local ||
                                      ScrabbleDictionary.isUnpacked)
                                    Radio(
                                      value: source,
                                      groupValue: provider.source,
                                      onChanged: provider.setSource,
                                    ),
                                  if (source == DictionarySources.local &&
                                      !ScrabbleDictionary.isUnpacked &&
                                      !provider.unzipReady)
                                    IconButton(
                                      icon: Icon(Icons.cloud_download),
                                      color: Theme.of(context).primaryColorDark,
                                      onPressed: () => download(context),
                                    ),
                                  if (source == DictionarySources.local &&
                                      provider.unzipReady)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 13.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const SizedBox(
                                              width: 20,
                                              height: 20,
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 3.0)),
                                        ],
                                      ),
                                    ),
                                  GestureDetector(
                                    onTap: source != DictionarySources.local ||
                                            ScrabbleDictionary.isUnpacked
                                        ? () => provider.setSource(source)
                                        : provider.unzipReady
                                            ? () {}
                                            : () => download(context),
                                    child: Text(
                                      source.label,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            Wrap(
                              runAlignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const SizedBox(width: 15),
                                Text("Nie wiesz który wybrać?"),
                                FlatButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    child: const DictionarySourcesInfoPopup(),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 13),
                                  child: const Text(
                                    "Dowiedz się więcej",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const ChoiceRemember()
                          ],
                        ),
                        const SizedBox(height: 1),
                        if (ModalRoute.of(context).settings.arguments != null)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: RaisedButton(
                              child: const Text("Rozpocznij rozgrywkę"),
                              onPressed: provider.source !=
                                          DictionarySources.local ||
                                      ScrabbleDictionary.isUnpacked
                                  ? () {
                                      Provider.of<Game>(context, listen: false)
                                          .startNewGame(
                                        ModalRoute.of(context)
                                            .settings
                                            .arguments,
                                      );
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        GameMenuScreen.routeName,
                                      );
                                    }
                                  : null,
                            ),
                          ),
                        if (ModalRoute.of(context).settings.arguments == null)
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: RaisedButton(
                              child: const Text("Zapisz"),
                              onPressed:
                                  provider.source != DictionarySources.local ||
                                          ScrabbleDictionary.isUnpacked
                                      ? () {
                                          Navigator.of(context).pop();
                                        }
                                      : null,
                            ),
                          ),
                        const SizedBox(height: 1),
                      ],
                    ),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

class ChoiceRemember extends StatelessWidget {
  const ChoiceRemember({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Checkbox(
              value: Provider.of<ScrabbleDictionary>(context).remembered,
              onChanged: (newValue) {
                Provider.of<ScrabbleDictionary>(context, listen: false)
                    .setRemembered(newValue);
              },
            ),
            GestureDetector(
                onTap: () {
                  Provider.of<ScrabbleDictionary>(context, listen: false)
                      .setRemembered(!Provider.of<ScrabbleDictionary>(context,
                              listen: false)
                          .remembered);
                },
                child: Text(
                  "Zapamiętaj mój wybór",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.normal),
                )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Można potem zmienić w ustwieniach",
            style: Theme.of(context).textTheme.caption,
          ),
        )
      ],
    );
  }
}
