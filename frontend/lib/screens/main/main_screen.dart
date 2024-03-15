import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/main_willicon_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainWilliconWidget(
                  text: '자필증서',
                  imagePath: 'assets/images/letter.png',
                ),
                MainWilliconWidget(
                  text: '녹음',
                  textColor: themeColour5,
                  borderColor: themeColour5,
                  imagePath: 'assets/images/voice.png',
                ),
                MainWilliconWidget(
                  text: '공정증서',
                  imagePath: 'assets/images/jury.png',
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MainWilliconWidget(
                  text: '비밀증서',
                  imagePath: 'assets/images/secret.png',
                ),
                MainWilliconWidget(
                  text: '구수증서',
                  imagePath: 'assets/images/emergency.png',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
