import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:growiq/core/services/groq_service.dart';
import 'package:growiq/core/services/service_locator.dart';
import 'package:growiq/features/auth/view_model/auth_cubit.dart';
import 'package:growiq/features/auth/view/views/forget_password_view.dart';
import 'package:growiq/features/auth/view/views/signup_view.dart';
import 'package:growiq/features/auth/view/views/login_view.dart';
import 'package:growiq/features/chat/view_model/chat_cubit.dart';
import 'package:growiq/features/notification/view/views/notification_view.dart';
import 'package:growiq/features/chat/view/views/chat_body_view.dart';
import 'package:growiq/features/chat/view/views/chat_view.dart';
import 'package:growiq/features/control/view/views/control_view.dart';
import 'package:growiq/features/control/view/views/device_detail_view.dart';
import 'package:growiq/features/home/view/views/home_view.dart';
import 'package:growiq/features/home/view/widgets/qr_scanner.dart';
import 'package:growiq/core/widgets/custom_navbar_shell.dart';
import 'package:growiq/features/me/view/views/me_view.dart';
import 'package:growiq/features/me/view/views/about_view.dart';
import 'package:growiq/features/me/view/views/profile_view.dart';
import 'package:growiq/features/me/view/views/settings_view.dart';
import 'package:growiq/features/me/view/views/plants_info_view.dart';
import 'package:growiq/features/me/view/views/contact_us_view.dart';
import 'package:growiq/features/onboarding/view/views/on_boarding_view.dart';
import 'package:growiq/features/splash/view/views/splash_screen.dart';

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
            BlocProvider(create: (_) => getIt<AuthCubit>(), child: const Loginview()),
      ),
      GoRoute(
        path: '/Signup',
        builder: (context, state) =>
            BlocProvider(create: (_) => getIt<AuthCubit>(), child: const SignupView()),
      ),
      GoRoute(
        path: '/forget-password',
        builder: (context, state) => BlocProvider(
          create: (_) => getIt<AuthCubit>(),
          child: const ForgetPasswordView(),
        ),
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
        builder: (context, state) => ProfileView(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsView(),
      ),
      GoRoute(path: '/about', builder: (context, state) => const AboutView()),
      GoRoute(
        path: '/plants-info',
        builder: (context, state) => const PlantsInfoView(),
      ),
      GoRoute(
        path: '/contact-us',
        builder: (context, state) => const ContactUsView(),
      ),

      /// -------- Standalone --------
      GoRoute(
        path: '/scanner',
        builder: (context, state) => const QRScannerPage(),
      ),
      GoRoute(
        path: '/device-detail',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return DeviceDetailView(
            deviceId: extra['deviceId'] as String,
            deviceName: extra['deviceName'] as String,
            isOnline: extra['isOnline'] as bool,
          );
        },
      ),
      GoRoute(
        path: '/chatbot',
        builder: (context, state) => const ChatIntroView(),
      ),
      GoRoute(
        path: '/start-chat',
        builder: (context, state) => BlocProvider(
          create: (_) => ChatCubit(getIt<GroqService>()),
          child: const ChatPage(),
        ),
      ),
    ],
  );
}
