import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:growiq/app/growiq_app.dart';
import 'package:growiq/core/database/cache/cache_helper.dart';
import 'package:growiq/core/functions/Check_state_changes.dart';
import 'package:growiq/core/services/service_locator.dart';
import 'package:growiq/core/widgets/app_connectivity_wrapper.dart';
import 'package:growiq/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🔹 Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 🔹 Setup Dependency Injection
  setupServiceLocator();

  // 🔹 Initialize Cache
  await getIt<CacheHelper>().init();

  // 🔹 Listen to auth state changes
  CheckStateChanges();

  // 🔹 Run App with Connectivity Wrapper
  runApp(
    AppConnectivityWrapper(
      child: const GrowIQ(),
    ),
  );
}
