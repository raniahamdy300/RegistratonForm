import 'package:flutter/material.dart';

class BuildPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final bool isPasswordVisible;
  final VoidCallback toggleVisibility;
  final String? Function(String?) validator;
  final VoidCallback? onFieldTap;
  final Function(String) onChanged;

  const BuildPasswordField(
      {super.key,
      required this.controller,
      required this.label,
      required this.hint,
      required this.isPasswordVisible,
      required this.toggleVisibility,
      required this.validator,
      this.onFieldTap,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: toggleVisibility,
        ),
      ),
      obscureText: !isPasswordVisible,
      validator: validator,
      onTap: onFieldTap,
      onChanged: onChanged,
    );
  }
}
