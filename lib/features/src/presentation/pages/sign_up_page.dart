import 'package:aditiswadi_mdtest/features/src/core/constant/validators.dart';
import 'package:aditiswadi_mdtest/features/src/core/theme/app_theme.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/bloc/user/user_bloc.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/widgets/custom_button.dart';
import 'package:aditiswadi_mdtest/features/src/presentation/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Passwords do not match!'),
            backgroundColor: kRedColor,
          ),
        );
        return;
      }
      context.read<UserBloc>().add(
        SignUpRequested(
          fullName: _fullNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Text(
          'Sign Up',
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
        ),
      );
    }

    Widget inputSection() {
      Widget fullNameInput() {
        return CustomTextFormField(
          title: 'Full Name',
          hintText: 'Your Full Name',
          controller: _fullNameController,
          validation: (String? val) =>
              Validators.validateField(val, "Full Name"),
        );
      }

      Widget emailInput() {
        return CustomTextFormField(
          title: 'Email Address',
          hintText: 'Your Email Address',
          controller: _emailController,
          validation: (String? val) => Validators.validateEmail(val),
        );
      }

      Widget passwordInput() {
        return CustomTextFormField(
          title: 'Password',
          hintText: 'Your Password',
          obscure: true,
          controller: _passwordController,
          validation: (String? val) =>
              Validators.validateField(val, "Password"),
        );
      }

      Widget confirmPasswordInput() {
        return CustomTextFormField(
          title: 'Confirm Password',
          hintText: 'Confirm Password',
          obscure: true,
          controller: _confirmPasswordController,
          validation: (String? val) =>
              Validators.validatePasswordMatch(val, _passwordController.text),
          onFieldSubmitted: (_) => _onSignUp(context),
        );
      }

      Widget submitButton() {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return CustomButton(
              title: state is UserLoading ? 'Loading...' : 'Sign Up',
              width: double.infinity,
              onPressed: () {
                _onSignUp(context);
              },
            );
          },
        );
      }

      return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          children: [
            fullNameInput(),
            emailInput(),
            passwordInput(),
            confirmPasswordInput(),
            submitButton(),
          ],
        ),
      );
    }

    Widget signInButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/sign-in',
            (route) => false,
          );
        },
        child: Container(
          margin: const EdgeInsets.only(top: 50, bottom: 73),
          alignment: Alignment.center,
          child: Text(
            'Have an account? Sign In',
            style: greyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: ligth,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      );
    }

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserAuthenticated) {
          Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
        } else if (state is UserError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sign Up Failed: ${state.message}'),
              backgroundColor: kRedColor,
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [title(), inputSection(), signInButton()],
            ),
          ),
        ),
      ),
    );
  }
}
