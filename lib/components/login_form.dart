import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  final String successText;
  final Future<(bool, String)> Function(String username, String password)
  onSuccessPress;
  final Future<String> Function(String username, String password) onSuccess;

  const LoginForm({
    super.key,
    required this.successText,
    required this.onSuccessPress,
    required this.onSuccess,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String? _email;
  String? _password;
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 8,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: "Email"),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your email";
              }
              return null;
            },
            onSaved: (newValue) {
              _email = newValue;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: "Password"),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              return null;
            },
            onSaved: (newValue) {
              _password = newValue;
            },
          ),
          if (_errorMessage != null)
            Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  (bool, String) result = await widget.onSuccessPress(
                    _email!,
                    _password!,
                  );
                  if (result.$1) {
                    String secondResult = await widget.onSuccess(_email!, _password!);

                    if (secondResult.isNotEmpty) {
                      setState(() {
                        _errorMessage = secondResult;
                      });                    
                    }
                  } else {
                    setState(() {
                      _errorMessage = result.$2;
                    });
                  }
                }
              },
              child: Text(widget.successText),
            ),
          ),
        ],
      ),
    );
  }
}
