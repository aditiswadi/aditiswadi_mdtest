import 'dart:async';
import 'package:aditiswadi_mdtest/features/src/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/bloc/user/user_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Timer? _timeoutTimer;

  @override
  void initState() {
    super.initState();
    _timeoutTimer = Timer(const Duration(seconds: 3), () {
      final userState = context.read<UserBloc>().state;
      if (!mounted) return;
      if (userState is! UserAuthenticated) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/sign-in',
          (route) => false,
        );
      }
    });
  }

  @override
  void dispose() {
    _timeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) =>
          current is UserAuthenticated || current is UserUnauthenticated,
      listener: (context, state) {
        _timeoutTimer?.cancel();
        if (state is UserAuthenticated) {
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        } else if (state is UserUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/sign-in',
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: Text(
            "aditiswadi_mdtest",
            style: whiteTextStyle.copyWith(fontSize: 24, fontWeight: bold),
          ),
        ),
      ),
    );
  }
}
