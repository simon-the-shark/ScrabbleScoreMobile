import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../widgets/logo.dart';
import '../widgets/resume_button.dart';
import 'history_screen.dart';
import 'users_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ScrabbleScore Mobile"),
        ),
        body: Center(
          child: SizedBox(
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Logo(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RaisedButton(
                      child: const Text("Nowa gra"),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(UsersScreen.routeName),
                    ),
                    const SizedBox(height: 10),
                    const ResumeButton(),
                    const SizedBox(height: 10),
                    RaisedButton(
                      color: Colors.deepPurple,
                      child: const Text("Historia"),
                      onPressed: () => Navigator.of(context)
                          .pushNamed(HistoryScreen.routeName),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
