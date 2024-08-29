import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/utils/validation.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.obscureText = false,
    required this.controller,
    required this.hintText,
    required this.labelText,
    this.validators,
    this.prefixIcon,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final bool obscureText;
  final String labelText;
  final String hintText;
  final IconData? prefixIcon;
  final List<Validation>? validators;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
      ),
      validator: validators?.validate,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: inputFormatters,
    );
  }
}
