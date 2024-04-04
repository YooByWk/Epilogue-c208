import 'package:flutter/material.dart';

class SocialButtonWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onPressed;

  const SocialButtonWidget({
    required this.imagePath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}// 

/* 
호출 예시
SocialButtonWidget(
  imagePath: 'assets/images/google_icon.png',
  onPressed: socialButtonViewModel.googleLogin,
  or 
  onPressed: ()=> debugPrint('google login button clicked!'), // void 함수라 괜찮습니다.
)

*/