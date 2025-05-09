import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/credentials_form.dart';

class RegisterRoute extends StatelessWidget {
  const RegisterRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Center(
        child: CredentialsForm(
          successText: "Register",
          onSuccessPress: (username, password) {
            return true;
          },
        ),
      )
    );
  }
}