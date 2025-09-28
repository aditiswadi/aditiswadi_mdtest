// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:aditiswadi_mdtest/features/src/core/theme/app_theme.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final String title;
  final bool obscure;
  final TextEditingController controller;
  final String? Function(String?)? validation;
  final Function(String)? onFieldSubmitted;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.title,
    this.obscure = false,
    required this.controller,
    this.validation,
    this.onFieldSubmitted,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: whiteTextStyle.copyWith(fontSize: 24, fontWeight: bold),
          ),
          const SizedBox(height: 6),
          TextFormField(
            cursorColor: kBlackColor,
            obscureText: widget.obscure,
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(17),
                borderSide: BorderSide(color: kPrimaryColor),
              ),
            ),
            validator: widget.validation,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: widget.onFieldSubmitted,
          ),
        ],
      ),
    );
  }
}
