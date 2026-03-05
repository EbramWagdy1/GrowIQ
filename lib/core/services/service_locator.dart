//take one copy of object and use it every where in the app
import 'package:get_it/get_it.dart';
import 'package:growiq/core/database/cache/cache_helper.dart';
import 'package:growiq/core/services/connectivity_service.dart';
import 'package:growiq/core/services/groq_service.dart';
import 'package:growiq/core/services/weather_service.dart';
import 'package:growiq/features/auth/view_model/auth_cubit.dart';
import 'package:growiq/features/home/view_model/weather_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';
import 'package:growiq/core/services/device_service.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerSingleton<AuthCubit>(AuthCubit());
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  getIt.registerLazySingleton<ConnectivityService>(
    () => ConnectivityService(getIt<Connectivity>()),
  );
  getIt.registerLazySingleton<GroqService>(() => GroqService());

  getIt.registerLazySingleton<WeatherService>(() => WeatherService());
  getIt.registerSingleton<WeatherCubit>(WeatherCubit(getIt<WeatherService>()));

  // Home Feature
  getIt.registerLazySingleton<DeviceService>(() => DeviceService());
  getIt.registerSingleton<DeviceCubit>(DeviceCubit(getIt<DeviceService>()));
}
