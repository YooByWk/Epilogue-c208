import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/common_button.dart';

class PopupWidget extends StatelessWidget {
  final String text;
  final String buttonText1;
  final String? buttonText2;
  final double fontSize;
  final bool isBold;
  final Color textColor;
  final VoidCallback onConfirm1;
  final VoidCallback? onConfirm2;


  const PopupWidget({
    required this.text,
    required this.buttonText1,
    this.buttonText2,
    this.fontSize = 20,
    this.isBold = false,
    this.textColor = Colors.black,
    required this.onConfirm1,
    this.onConfirm2,

    super.key,
});

  @override
  Widget build(BuildContext context) {

    List<Widget> actionWidgets = [
      CommonButtonWidget(
        text: buttonText1,
        onPressed: onConfirm1,
        backgroundColor: (buttonText2 != null) ? Colors.grey : themeColour5,
      ),
    ];

    // buttonText2가 null이 아닐 경우 두 번째 버튼 추가
    if (buttonText2 != null && onConfirm2 != null) {
      actionWidgets.add(
        CommonButtonWidget(
          text: buttonText2!,
          onPressed: onConfirm2!,
          backgroundColor: (buttonText2 != null) ? themeColour5 : Colors.grey,
        ),
      );
    }

    return AlertDialog(
      content: SingleChildScrollView(
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: isBold ?  FontWeight.bold : FontWeight.normal,
              fontSize: fontSize,
              color: textColor,
                ),
          ),
        ),
      ),
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 100,
      ),
      actions: actionWidgets,
    );
  }
}
