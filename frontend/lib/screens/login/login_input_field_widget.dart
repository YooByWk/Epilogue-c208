import 'package:flutter/material.dart';

class LoginInputField extends StatelessWidget {
  final String label;
  final double padding;
  final bool obscureText;
  final ValueChanged<String> onChanged;

  const LoginInputField({
    Key? key,
    required this.label,
    this.padding = 80,
    this.obscureText = false,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 0,
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFececec)),
            ),
          ),
          TextFormField(
            style: TextStyle(color: Color(0xFFececec), fontSize: 24),
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: padding),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFececec))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFFececec))),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
