import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import 'helpers/locator.dart';
import 'providers/game.dart';
import 'providers/games.dart';
import 'providers/scrabble_dictionary.dart';
import 'screens/dictionary_screen.dart';
import 'screens/final_screen.dart';
import 'screens/game_menu_screen.dart';
import 'screens/history_screen.dart';
import 'screens/home_screen.dart';
import 'screens/result_screen.dart';
import 'screens/users_screen.dart';
import 'widgets/game_pop_scope.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.teal[700], // status bar color
  // ));
  initializeDateFormatting("pl_PL");
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
        ChangeNotifierProvider.value(value: locator<ScrabbleDictionary>()),
        ChangeNotifierProvider(create: (_) => Games()),
      ],
      child: OverlaySupport(
        child: MaterialApp(
          title: 'ScrabbleScore Mobile',
          theme: ThemeData(
            primarySwatch: Colors.teal,
            visualDensity: VisualDensity.adaptivePlatformDensity,
            buttonTheme: ButtonThemeData(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              materialTapTargetSize: MaterialTapTargetSize.padded,
              buttonColor: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(13),
              ),
              textTheme: ButtonTextTheme.primary,
            ),
          ),
          home: HomeScreen(),
          routes: {
            UsersScreen.routeName: (context) => UsersScreen(),
            GameMenuScreen.routeName: (context) =>
                GamePopScope(child: GameMenuScreen()),
            FinalScreen.routeName: (context) => FinalScreen(),
            ResultScreen.routeName: (context) => ResultScreen(),
            HistoryScreen.routeName: (context) => HistoryScreen(),
            DictionaryScreen.routeName: (context) => DictionaryScreen(),
          },
        ),
      ),
    );
  }
}
