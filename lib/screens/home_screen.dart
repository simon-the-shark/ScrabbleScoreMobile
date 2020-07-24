import 'package:app/widgets/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../widgets/name_widget.dart';
import '../widgets/resume_button.dart';
import 'history_screen.dart';
import 'users_screen.dart';

class HomeScreen extends StatelessWidget {
  static const edgeInsets =
      const EdgeInsets.symmetric(horizontal: 30, vertical: 18);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const StatusBar(),
        SafeArea(
          child: Center(
            child: Column(
              children: [
                Expanded(
                  child: const NameWidget(),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(
                    width: 250,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          child: const Text("Nowa gra"),
                          padding: edgeInsets,
                          onPressed: () => Navigator.of(context)
                              .pushNamed(UsersScreen.routeName),
                        ),
                        const SizedBox(height: 10),
                        const ResumeButton(),
                        const SizedBox(height: 10),
                        RaisedButton(
                          color: Colors.deepPurple,
                          padding: edgeInsets,
                          child: const Text("Historia"),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(HistoryScreen.routeName),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
