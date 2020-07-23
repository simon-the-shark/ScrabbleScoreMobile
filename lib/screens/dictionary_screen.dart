import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../providers/scrabble_dictionary.dart';
import '../widgets/dictionary_sources_info_popup.dart';
import '../widgets/download_info_popup.dart';
import 'game_menu_screen.dart';

class DictionaryScreen extends StatelessWidget {
  static const routeName = "/dictionary-source";

  void download(BuildContext context) async {
    await showDialog(context: context, child: const DowloadInfoPopup());
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ScrabbleDictionary>(context);
    var appBar = AppBar(
      title: const Text("Źródło słownika"),
    );
    return Scaffold(
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
                                    ScrabbleDictionary.isDownloaded)
                                  Radio(
                                    value: source,
                                    groupValue: provider.source,
                                    onChanged: provider.setSource,
                                  ),
                                if (source == DictionarySources.local &&
                                    !ScrabbleDictionary.isDownloaded)
                                  IconButton(
                                    icon: Icon(Icons.cloud_download),
                                    color: Theme.of(context).primaryColorDark,
                                    onPressed: () => download(context),
                                  ),
                                GestureDetector(
                                  onTap: source != DictionarySources.local ||
                                          ScrabbleDictionary.isDownloaded
                                      ? () => provider.setSource(source)
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
                          const SizedBox(height: 15),
                          Wrap(
                            runAlignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const SizedBox(width: 5),
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
                        ],
                      ),
                      const SizedBox(height: 1),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: RaisedButton(
                          child: const Text("Rozpocznij rozgrywkę"),
                          onPressed: provider.source !=
                                      DictionarySources.local ||
                                  ScrabbleDictionary.isDownloaded
                              ? () {
                                  Provider.of<Game>(context, listen: false)
                                      .startNewGame(
                                    ModalRoute.of(context).settings.arguments,
                                  );
                                  Navigator.of(context).pushReplacementNamed(
                                    GameMenuScreen.routeName,
                                  );
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
    );
  }
}
