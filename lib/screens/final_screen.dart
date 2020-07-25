import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../widgets/final_scrable_keyboard.dart';
import '../widgets/user_final_input.dart';
import 'result_screen.dart';

class FinalScreen extends StatefulWidget {
  static const routeName = "/final";

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  final Map<int, FocusNode> fNodes = {
    1: FocusNode(),
    2: FocusNode(),
    3: FocusNode(),
    4: FocusNode()
  };
  final Map<int, ValueNotifier<String>> notifiers = {
    1: ValueNotifier<String>(""),
    2: ValueNotifier<String>(""),
    3: ValueNotifier<String>(""),
    4: ValueNotifier<String>(""),
  };
  void nextFocus() {
    var current =
        fNodes.entries.firstWhere((element) => element.value.hasFocus);
    if (current == null) return;
    current.value.unfocus();
    var players = Provider.of<Game>(context, listen: false).players;
    var indx = players.indexWhere((element) => element.key == current.key);
    if (indx < players.length - 1) fNodes[players[indx + 1].key].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const Text("Niewykorzystane płytki"));
    var players = Provider.of<Game>(context).players;
    return WillPopScope(
      onWillPop: () async {
        if (!fNodes.entries.any((element) => element.value.hasFocus))
          return true;
        FocusScope.of(context).unfocus();
        return false;
      },
      child: Scaffold(
        appBar: appBar,
        body: KeyboardActions(
          config: KeyboardActionsConfig(
            keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
            keyboardBarColor: Colors.grey[200],
            nextFocus: false,
            actions: [
              for (var player in players)
                KeyboardAction(
                  focusNode: fNodes[player.key],
                  displayActionBar: false,
                  footerBuilder: (_) => FinalScrabbleKeyboard(
                    notifier: notifiers[player.key],
                    hideKeyboard: nextFocus,
                  ),
                ),
            ],
          ),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width,
                    maxWidth: MediaQuery.of(context).size.width,
                    minHeight: MediaQuery.of(context).size.height -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        for (var player in players)
                          UserFinalInput(
                            player.key,
                            player.value,
                            focusNode: fNodes[player.key],
                            notifier: notifiers[player.key],
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: RaisedButton(
                        child: const Text("Zobacz wyniki"),
                        onPressed: () {
                          Provider.of<Game>(context, listen: false)
                              .finalModifying();
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              ResultScreen.routeName, (route) => route.isFirst);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
