import 'package:app/screens/word_screen.dart';
import 'package:app/widgets/blank_lock_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import '../providers/game.dart';

GetIt locator = GetIt.instance..allowReassignment = true;

void setupLocator() {
  locator.registerLazySingleton(() => Game());
  locator.registerLazySingleton(() => GlobalKey<BlankLockButtonState>());
  locator.registerLazySingleton(() => GlobalKey<WordScreenState>());
}

GlobalKey<BlankLockButtonState> newBlankLockKey() {
  locator.registerSingleton(GlobalKey<BlankLockButtonState>());
  return locator<GlobalKey<BlankLockButtonState>>();
}

GlobalKey<WordScreenState> newWordScreenKey() {
  locator.registerSingleton(GlobalKey<WordScreenState>());
  return locator<GlobalKey<WordScreenState>>();
}
