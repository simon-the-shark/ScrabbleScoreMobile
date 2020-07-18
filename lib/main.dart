import 'package:app/screens/game_menu_screen.dart';
import 'package:app/widgets/game_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/locator.dart';
import 'providers/game.dart';
import 'screens/home_screen.dart';
import 'screens/users_screen.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Game()),
      ],
      child: MaterialApp(
        title: 'ScrabbleScoreMobile',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(),
        routes: {
          UsersScreen.routeName: (context) => UsersScreen(),
          GameMenuScreen.routeName: (context) => GamePopScope(
                child: GameMenuScreen(),
              ),
        },
      ),
    );
  }
}
