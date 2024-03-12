import 'package:flutter/material.dart';

class SignUpInput extends StatelessWidget {
  final String label;
  final String action;
  final bool obscureText;
  SignUpInput({required this.label, this.action = '', this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Text(label),
            TextField(
              obscureText: obscureText,
            ),
            Text(action),
    
          ],
        ),
      );
  }
}