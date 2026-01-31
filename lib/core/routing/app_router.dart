import 'package:go_router/go_router.dart';
import 'package:growiq/feauters/Auth/presentation/views/login.dart';
import 'package:growiq/feauters/onboarding/presentation/views/on_boarding_view.dart';
import 'package:growiq/feauters/splach/presentation/views/splach_screen.dart';
class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashView(),
      
      
      ),
        GoRoute(
        path: '/onBoarding',
        builder: (context, state) => const OnBoardingview(),

      
      ),
        GoRoute(
        path: '/Login',
        builder: (context, state) => const Loginview(),

      
      ),
          // builder: (context, state) => const SplachScreen(),
      // ),
    ],
    initialLocation: '/',

  );
}