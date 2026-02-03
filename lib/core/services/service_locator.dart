//take one copy of object and use it every where in the app
import 'package:get_it/get_it.dart';
import 'package:growiq/core/database/cache/cache_helper.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
}