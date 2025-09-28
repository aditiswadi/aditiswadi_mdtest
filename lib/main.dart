import 'package:aditiswadi_mdtest/features/src/presentation/bloc/home/home_bloc.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/bloc/navigation/navigation_bloc.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/bloc/user/user_bloc.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/pages/main_page.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/pages/reset_password_page.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/pages/settings_page.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/pages/sign_in_page.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/pages/sign_up_page.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/pages/splash_page.dart';
import 'package:aditiswadi_mdtest/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aditiswadi_mdtest/features/src/core/services/services_locator.dart'
    as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider(create: (context) => di.sl<UserBloc>()),
        BlocProvider(create: (context) => di.sl<HomeBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => SplashPage(),
          '/sign-up': (context) => SignUpPage(),
          '/sign-in': (context) => SignInPage(),
          '/main': (context) => MainPage(),
          '/settings': (context) => SettingsPage(),
          '/reset-password': (context) => ResetPasswordPage(),
        },
      ),
    );
  }
}
