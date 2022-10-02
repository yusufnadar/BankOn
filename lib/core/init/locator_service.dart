import 'package:control_bank_accounts/core/init/database_helper_service.dart';
import 'package:get_it/get_it.dart';
import 'local_service.dart';

class Locator {
  static final getIt = GetIt.instance;

  static setupLocator() {
    getIt.registerLazySingleton(() => LocalService());
    getIt.registerLazySingleton(() => DatabaseHelperService());
  }
}