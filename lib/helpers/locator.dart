import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../providers/scrabble_dictionary.dart';
import '../screens/word_screen.dart';
import '../widgets/blank_lock_button.dart';
import '../widgets/cursor.dart';

GetIt locator = GetIt.instance..allowReassignment = true;

void setupLocator() {
  locator.registerLazySingleton(() => ScrabbleDictionary());
  locator.registerLazySingleton(() => GlobalKey<BlankLockButtonState>());
  locator.registerLazySingleton(() => GlobalKey<WordScreenState>());
  locator.registerLazySingleton(() => GlobalKey<CursorState>());
}

GlobalKey<BlankLockButtonState> newBlankLockKey() {
  locator.registerSingleton(GlobalKey<BlankLockButtonState>());
  return locator<GlobalKey<BlankLockButtonState>>();
}

GlobalKey<WordScreenState> newWordScreenKey() {
  locator.registerSingleton(GlobalKey<WordScreenState>());
  return locator<GlobalKey<WordScreenState>>();
}

GlobalKey<CursorState> newCursorKey() {
  locator.registerSingleton(GlobalKey<CursorState>());
  return locator<GlobalKey<CursorState>>();
}
