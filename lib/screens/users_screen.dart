import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game.dart';
import '../widgets/add_user_widget.dart';
import '../widgets/user_input_widget.dart';
import 'game_menu_screen.dart';

class UsersScreen extends StatefulWidget {
  static const routeName = "/users";

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final List<String> values = ["", "", "", null, null];
  final List<FocusNode> fNodes = [
    null,
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];

  void addUser(int number) => setState(() {
        values[number] = "";
      });
  void deleteUser(int number) => setState(() {
        values.removeAt(number);
        values.add(null);
      });

  @override
  Widget build(BuildContext context) {
    final nullIndex = values.indexOf(null);
    final appBar = AppBar(title: const Text("Dodaj graczy"));
    return Scaffold(
      appBar: appBar,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width,
              maxWidth: MediaQuery.of(context).size.width,
              minHeight: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).padding.top -
                  appBar.preferredSize.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    UserInputWidget(
                      1,
                      values,
                      null,
                      focusNode: fNodes[1],
                    ),
                    UserInputWidget(
                      2,
                      values,
                      null,
                      focusNode: fNodes[2],
                    ),
                    if (values[3] != null)
                      UserInputWidget(
                        3,
                        values,
                        deleteUser,
                        textController: TextEditingController(text: values[3]),
                        focusNode: fNodes[3],
                      ),
                    if (values[4] != null)
                      UserInputWidget(
                        4,
                        values,
                        deleteUser,
                        textController: TextEditingController(text: values[4]),
                        focusNode: fNodes[4],
                      ),
                    if (nullIndex != -1) AddUserWidget(nullIndex, addUser),
                    if (values[3] == null)
                      Opacity(opacity: 0, child: AddUserWidget(1, (i) {})),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: RaisedButton(
                    child: const Text("Rozpocznij rozgrywkę"),
                    onPressed: () {
                      Provider.of<Game>(context, listen: false)
                          .setPlayersNames(values);
                      Navigator.of(context).pushReplacementNamed(
                        GameMenuScreen.routeName,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
