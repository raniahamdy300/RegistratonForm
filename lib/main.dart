import 'package:flutter/material.dart';
import 'package:registeration/views/Registeration_form.dart';

void main() {
  runApp(const RegisterNow());
}

class RegisterNow extends StatelessWidget {
  const RegisterNow({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registeration Form',
      home: RegistrationForm(),
    );
  }
}
