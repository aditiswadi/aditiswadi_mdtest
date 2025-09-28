import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/bloc/user/user_bloc.dart';
import 'package:aditiswadi_mdtest/features/src/core/theme/app_theme.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/widgets/custom_button.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/widgets/custom_text_form_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _emailSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserActionSuccess) {
            setState(() => _emailSent = true);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: kGreenColor,
              ),
            );
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: kRedColor,
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFormField(
                title: 'Email',
                hintText: 'Enter your email',
                controller: _emailController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                // Tambahkan keyboardType jika diperlukan
                // keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              CustomButton(
                title: 'Send Reset Email',
                width: double.infinity,
                onPressed: _emailSent
                    ? () {}
                    : () {
                        final email = _emailController.text.trim();
                        if (email.isNotEmpty) {
                          context.read<UserBloc>().add(
                            ResetPasswordRequested(email),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please enter your email',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 24,
                                  fontWeight: bold,
                                ),
                              ),
                            ),
                          );
                        }
                      },
              ),
              if (_emailSent)
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'A password reset email has been sent. Please check your inbox.',
                    style: whiteTextStyle.copyWith(
                      fontSize: 24,
                      fontWeight: bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
