import 'package:growiq/core/database/cache/cache_helper.dart';
import 'package:growiq/core/services/service_locator.dart';
void onboardingvisit() {
  getIt<CacheHelper>().saveData(key: 'isFirstTime', value: true);
}