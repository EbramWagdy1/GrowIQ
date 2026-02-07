import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:growiq/feauters/Auth/presentation/Auth_cuibt/cubit/auth_cubit.dart';
import 'package:growiq/feauters/Auth/presentation/views/ForgetPasswordView.dart';
import 'package:growiq/feauters/Auth/presentation/views/SignupView.dart';
import 'package:growiq/feauters/Auth/presentation/views/login.dart';
import 'package:growiq/feauters/home/presentation/views/home_view.dart';
import 'package:growiq/feauters/onboarding/presentation/views/on_boarding_view.dart';
import 'package:growiq/feauters/splach/presentation/views/splach_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: '/onBoarding',
        builder: (context, state) => const OnBoardingview(),
      ),
      GoRoute(
        path: '/Login',
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const Loginview(),
        ),
      ),
      GoRoute(path: '/Home', builder: (context, state) => const HomeView()),
      GoRoute(
        path: '/Signup',
        builder: (context, state) => BlocProvider(
          create: (context) =>AuthCubit(),
          child: const SignupView(),
        ),
      ),
      GoRoute(
        path: '/ForgetPasswordView',
        builder: (context, state) => const ForgetPasswordView(),
      ),
      // builder: (context, state) => const SplachScreen(),
      // ),
    ],
    initialLocation: '/',
  );
}
