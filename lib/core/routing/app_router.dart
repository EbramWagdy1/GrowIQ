import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:growiq/feauters/Auth/presentation/Auth_cuibt/cubit/auth_cubit.dart';
import 'package:growiq/feauters/Auth/presentation/views/ForgetPasswordView.dart';
import 'package:growiq/feauters/Auth/presentation/views/SignupView.dart';
import 'package:growiq/feauters/Auth/presentation/views/login.dart';
import 'package:growiq/feauters/Notification/presentation/Notification_View.dart';
import 'package:growiq/feauters/chat/presentation/chat_view.dart';
import 'package:growiq/feauters/control/presentation/Control_view.dart';
import 'package:growiq/feauters/home/presentation/views/home_view.dart';
import 'package:growiq/feauters/home/presentation/widgets/QR_Scanner.dart';
import 'package:growiq/core/widgets/custom_navbar_shell.dart';
import 'package:growiq/feauters/me/presentation/Me_View.dart';
import 'package:growiq/feauters/me/presentation/about_view.dart';
import 'package:growiq/feauters/me/presentation/profile_view.dart';
import 'package:growiq/feauters/me/presentation/settings_view.dart';
import 'package:growiq/feauters/onboarding/presentation/views/on_boarding_view.dart';
import 'package:growiq/feauters/splach/presentation/views/splach_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      /// -------- Auth & Intro --------
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: '/onBoarding',
        builder: (context, state) => const OnBoardingview(),
      ),
      GoRoute(
        path: '/Login',
        builder: (context, state) =>
            BlocProvider(create: (_) => AuthCubit(), child: const Loginview()),
      ),
      GoRoute(
        path: '/Signup',
        builder: (context, state) =>
            BlocProvider(create: (_) => AuthCubit(), child: const SignupView()),
      ),
      GoRoute(
        path: '/forget-password',
        builder: (context, state) => const ForgetPasswordView(),
      ),

      /// -------- Main App (With Bottom Nav) --------
      ShellRoute(
        builder: (context, state, child) {
          return CustomNavBarShell(child: child);
        },
        routes: [
          GoRoute(path: '/Home', builder: (context, state) => const HomeView()),

          GoRoute(
            path: '/control',
            builder: (context, state) => const ControlView(),
          ),
          GoRoute(
            path: '/notification',
            builder: (context, state) => const NotificationView(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const MeView(),
          ),
        ],
      ),

      /// -------- ME View --------
      GoRoute(
        path: '/profile-data',
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutView(),
      ),

      /// -------- Standalone --------
      GoRoute(
        path: '/scanner',
        builder: (context, state) => const QRScannerPage(),
      ),
      GoRoute(
        path: '/chatbot',
        builder: (context, state) => const ChatIntroView(),
      ),
    ],
  );
}
