import 'package:get_it/get_it.dart';

import '../providers/game.dart';

GetIt locator = GetIt.instance..allowReassignment = true;

void setupLocator() {
  locator.registerLazySingleton(() => Game());
}
