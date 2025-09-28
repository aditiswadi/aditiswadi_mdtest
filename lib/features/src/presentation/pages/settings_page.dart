import 'package:aditiswadi_mdtest/features/src/core/theme/app_theme.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/bloc/user/user_bloc.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserActionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: kGreenColor,
            ),
          );
        }
        if (state is UserUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/sign-in',
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is UserAuthenticated || state is UserActionSuccess) {
          final user = state is UserAuthenticated
              ? state.user
              : (state as UserActionSuccess).user;

          return Scaffold(
            backgroundColor: kBackgroundColor,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user.fullName,
                      style: blackTextStyle.copyWith(
                        fontSize: 24,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      user.email,
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          user.isVerified
                              ? Icons.verified
                              : Icons.error_outline,
                          color: user.isVerified ? kGreenColor : kRedColor,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          user.isVerified ? "Verified" : "Not Verified",
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: bold,
                          ),
                        ),
                      ],
                    ),

                    if (!user.isVerified) ...[
                      const SizedBox(height: 20),
                      CustomButton(
                        title: "Send Verification Email",
                        width: double.infinity,
                        onPressed: () {
                          context.read<UserBloc>().add(
                            SendEmailVerificationRequested(),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomButton(
                        title: "Refresh Verification Status",
                        width: double.infinity,
                        onPressed: () {
                          context.read<UserBloc>().add(
                            RefreshEmailVerificationStatus(),
                          );
                        },
                      ),
                    ],

                    const SizedBox(height: 20),
                    CustomButton(
                      title: "Sign Out",
                      width: double.infinity,
                      onPressed: () {
                        context.read<UserBloc>().add(SignOutRequested());
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      title: "Reset Password",
                      width: double.infinity,
                      onPressed: () {
                        Navigator.pushNamed(context, '/reset-password');
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is UserLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('Terjadi masalah, silakan coba lagi.')),
          );
        }
      },
    );
  }
}
