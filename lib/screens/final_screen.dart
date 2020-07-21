import 'package:app/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../widgets/final_scrable_keyboard.dart';
import '../widgets/user_final_input.dart';

class FinalScreen extends StatefulWidget {
  static const routeName = "/final";

  @override
  _FinalScreenState createState() => _FinalScreenState();
}

class _FinalScreenState extends State<FinalScreen> {
  final List<FocusNode> fNodes = [
    null,
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  final List<ValueNotifier<String>> notifiers = [
    null,
    ValueNotifier<String>(""),
    ValueNotifier<String>(""),
    ValueNotifier<String>(""),
    ValueNotifier<String>(""),
  ];
  void nextFocus() {
    var current = fNodes
        .indexWhere((element) => element is FocusNode && element.hasFocus);
    if (current == -1) return;
    fNodes[current].unfocus();
    if (current != Provider.of<Game>(context, listen: false).players.length)
      fNodes[current + 1].requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(title: const Text("Niewykorzystane płytki"));
    var players = Provider.of<Game>(context).players;
    return WillPopScope(
      onWillPop: () async {
        if (!fNodes.any((element) => element is FocusNode && element.hasFocus))
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
                    RaisedButton(
                      child: const Text("Zobacz wyniki"),
                      onPressed: () {
                        Provider.of<Game>(context, listen: false)
                            .finalModifying();
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                        Navigator.of(context).pushNamed(ResultScreen.routeName);
                      },
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
