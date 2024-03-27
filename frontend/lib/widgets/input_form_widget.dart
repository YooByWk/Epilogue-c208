import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/main.dart';

class InputFormWidget extends StatelessWidget {
  final String label;
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? height;
  final double? fontSize;
  final EdgeInsets padding;
  final EdgeInsets contentPadding;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final String? hintText;
  final TextStyle? hintTextStyle;

  InputFormWidget({
    required this.label,
    this.textColor = Colors.black,
    this.backgroundColor,
    this.borderColor,
    this.height = 60.0,
    this.fontSize = 24.0,
    this.padding = const EdgeInsets.only(left: 10),
    this.contentPadding = const EdgeInsets.only(bottom: 5, left: 100),
    required this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.number,
    this.textInputAction = TextInputAction.next,
    this.hintText,
    this.hintTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.transparent,
          border: Border.all(
            color: borderColor ?? themeColour3,
          ),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
                left: 0,
                child: Container(
                  padding: padding,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: fontSize,
                      color: textColor,
                    ),
                  ),
                )),
            TextFormField(
              onChanged: onChanged,
              obscureText: obscureText,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: contentPadding,
                hintText: hintText,
                hintStyle: hintTextStyle,
              ),
            ),
          ],
        ));
  }
}
