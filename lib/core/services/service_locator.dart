//take one copy of object and use it every where in the app
import 'package:get_it/get_it.dart';
import 'package:growiq/core/database/cache/cache_helper.dart';
import 'package:growiq/core/services/connectivity_service.dart';
import 'package:growiq/core/services/groq_service.dart';
import 'package:growiq/core/services/weather_service.dart';
import 'package:growiq/features/home/view_model/weather_cubit.dart';
import 'package:growiq/features/home/repository/weather_repository.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:growiq/features/control/view_model/device_cubit.dart';
import 'package:growiq/core/services/device_service.dart';
import 'package:growiq/core/services/auth_service.dart';
import 'package:growiq/core/services/cloudinary_service.dart';
import 'package:growiq/features/auth/view_model/auth_cubit.dart';
import 'package:growiq/core/theme/theme_cubit.dart';
import 'package:growiq/core/l10n/locale_cubit.dart';
import 'package:growiq/core/services/notification_service.dart';
import 'package:growiq/features/notification/view_model/notification_cubit.dart';
import 'package:growiq/features/control/repository/device_repository.dart';
import 'package:growiq/features/notification/repository/notification_repository.dart';
import 'package:growiq/features/auth/repository/auth_repository.dart';
import 'package:growiq/features/chat/repository/chat_repository.dart';
import 'package:growiq/features/chat/view_model/chat_cubit.dart';
import 'package:growiq/features/me/repository/plant_repository.dart';
import 'package:growiq/features/me/view_model/plants_cubit.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<CacheHelper>(CacheHelper());
  getIt.registerLazySingleton<ThemeCubit>(() => ThemeCubit(getIt<CacheHelper>()));
  getIt.registerLazySingleton<LocaleCubit>(() => LocaleCubit(getIt<CacheHelper>()));
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

  getIt.registerLazySingleton<ConnectivityService>(
    () => ConnectivityService(getIt<Connectivity>()),
  );
  getIt.registerLazySingleton<GroqService>(() => GroqService());
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepository(getIt<GroqService>()));
  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt<ChatRepository>()));

  getIt.registerLazySingleton<WeatherService>(() => WeatherService());
  getIt.registerLazySingleton<WeatherRepository>(
    () => WeatherRepository(getIt<WeatherService>(), getIt<CacheHelper>()),
  );
  getIt.registerLazySingleton<WeatherCubit>(
    () => WeatherCubit(getIt<WeatherRepository>()),
  );

  // Home Feature / Control Feature
  getIt.registerLazySingleton<DeviceService>(() => DeviceService());
  getIt.registerLazySingleton<DeviceRepository>(
    () => DeviceRepository(getIt<DeviceService>()),
  );
  getIt.registerLazySingleton<DeviceCubit>(
    () => DeviceCubit(getIt<DeviceRepository>(), getIt<AuthService>()),
  );

  // Auth Feature / Notification Feature
  getIt.registerLazySingleton<AuthService>(() => AuthService());
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt<AuthService>()));
  getIt.registerLazySingleton<CloudinaryService>(() => CloudinaryService());
  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  getIt.registerLazySingleton<NotificationRepository>(() => NotificationRepository());
  getIt.registerLazySingleton<NotificationCubit>(
    () => NotificationCubit(getIt<NotificationRepository>()),
  );
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(getIt<AuthRepository>(), getIt<CloudinaryService>()),
  );

  // Me Feature / Plants Info
  getIt.registerLazySingleton<PlantRepository>(() => PlantRepository());
  getIt.registerLazySingleton<PlantsCubit>(() => PlantsCubit(getIt<PlantRepository>()));
}
