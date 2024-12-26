import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:registeration/widgets/build_password_field.dart';
import 'package:registeration/widgets/build_text_field.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _termsAgreed = false;
  bool _showPwValidator = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    setState(() {
      _termsAgreed = false;
      _showPwValidator = false;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    });
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_termsAgreed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful')),
        );
        _clearFields();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please agree to the terms')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Registration Form'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              BuildTextField(
                controller: _nameController,
                label: 'Name',
                hint: 'Enter your full name',
                prefixIcon: Icons.person,
                keyboardType: TextInputType.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (value) {
                  _formKey.currentState?.validate();
                },
              ),
              const SizedBox(height: 16),
              BuildTextField(
                controller: _emailController,
                label: 'Email Address',
                hint: 'Enter your email',
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                onChanged: (value) {
                  _formKey.currentState?.validate();
                },
              ),
              const SizedBox(height: 16),
              BuildPasswordField(
                controller: _passwordController,
                label: 'Password',
                hint: 'Enter your password',
                isPasswordVisible: _isPasswordVisible,
                toggleVisibility: _togglePasswordVisibility,
                validator: (value) => value == null || value.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
                onFieldTap: () => setState(() => _showPwValidator = true),
                onChanged: (value) {
                  _formKey.currentState?.validate();
                },
              ),
              const SizedBox(height: 8),
              if (_showPwValidator)
                FlutterPwValidator(
                  controller: _passwordController,
                  minLength: 6,
                  uppercaseCharCount: 1,
                  numericCharCount: 1,
                  specialCharCount: 1,
                  width: 400,
                  height: 150,
                  onSuccess: () {},
                ),
              const SizedBox(height: 16),
              BuildPasswordField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                hint: 'Re-enter your password',
                isPasswordVisible: _isConfirmPasswordVisible,
                toggleVisibility: _toggleConfirmPasswordVisibility,
                validator: (value) => value != _passwordController.text
                    ? 'Passwords do not match'
                    : null,
                onChanged: (value) {
                  _formKey.currentState?.validate();
                },
              ),
              const SizedBox(height: 24),
              CheckboxListTile(
                title: const Text('I agree to the Terms and Conditions'),
                value: _termsAgreed,
                onChanged: (value) {
                  setState(() {
                    _termsAgreed = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF5722),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: _onSubmit,
                child: const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
