import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/main.dart';

class InputFormWidget extends StatefulWidget {
  final String text;
  final Color textColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final Border? border;
  final BorderRadius? radius;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;

  const InputFormWidget({
    Key? key,
    required this.text,
    this.backgroundColor = themeColour3,
    this.borderColor = themeColour3,
    this.textColor = Colors.black,
    required this.controller,
    this.width = 150.0,
    this.height = 60.0,
    this.fontSize = 24.0,
    this.border,
    this.radius = const BorderRadius.all(Radius.circular(8.0)),
    this.keyboardType = TextInputType.number,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  _InputFormWidgetState createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends State<InputFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.transparent,
          borderRadius: widget.radius,
          border: Border.all(
            color: widget.borderColor ?? themeColour3,
          ),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: widget.fontSize,
                  color: widget.textColor,
                ),
              ),
            ),
            TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              style: TextStyle(
                color: themeColour5,
                fontSize: widget.fontSize,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 130, bottom: 5),
              ),
            ),
          ],
        ));
  }
}
