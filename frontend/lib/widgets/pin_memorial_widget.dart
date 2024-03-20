import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_screen.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/main.dart';

class PinMemorialWidget extends StatelessWidget {
  const PinMemorialWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CommonButtonWidget(
        height: 300,
        width: 300,
        text: '묘비명\n故김싸피',
        fontSize: 24,
        textColor: Colors.black,
        imagePath: 'assets/images/stone.png',
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MemorialScreen()));
        },
      ),
    );
  }
}
