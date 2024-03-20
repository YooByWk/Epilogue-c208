import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/main.dart';

class InputFormWidget extends StatefulWidget {
  final String label;
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
    required this.label,
    this.backgroundColor = themeColour3,
    this.textColor = Colors.black,
    this.borderColor = themeColour3, // 기본 비활성화 색
    required this.controller,
    this.width = 150.0,
    this.height = 50.0,
    this.fontSize = 16.0,
    this.border,
    this.radius = const BorderRadius.all(Radius.circular(8.0)),
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
  }) : super(key: key);

  @override
  _InputFormWidgetState createState() => _InputFormWidgetState();
}

class _InputFormWidgetState extends State<InputFormWidget> {
  late FocusNode _focusNode;
  Color? _borderColor;
  Color? _labelColor;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _borderColor = widget.borderColor ?? Colors.grey;
    _labelColor = themeColour3; // 초기 라벨 색상

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          _borderColor = themeColour5; // 포커스 시 테두리 색상
          _labelColor = themeColour5; // 포커스 시 라벨 색상
        });
      } else {
        setState(() {
          _borderColor = widget.borderColor ?? Colors.grey;
          _labelColor = themeColour3; // 포커스 잃었을 때 라벨 색상
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.transparent,
          borderRadius: widget.radius,
          border: widget.border ??
              Border.all(
                color: _borderColor ?? themeColour3,
              ),
        ),
          alignment: Alignment.centerLeft,
          child: TextFormField(
              controller: widget.controller,
              focusNode: _focusNode,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              style: TextStyle(
                color: widget.textColor,
                fontSize: widget.fontSize,
              ),
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: TextStyle(color: _labelColor),
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(left: 8, bottom: 8, top: 8),
              ),
            ),
    );
  }
}
