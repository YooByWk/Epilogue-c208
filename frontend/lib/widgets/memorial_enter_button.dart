import 'package:flutter/material.dart';

class MemorialEnterButton extends StatelessWidget {
  final bool isFocused;
  final VoidCallback onTap;

  MemorialEnterButton({
    required this.isFocused,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (isFocused) {
      return Container(); // 입력 필드에 포커스가 있을 때는 아무것도 표시하지 않음
    }

    return Positioned(
      height: MediaQuery.of(context).size.height * 0.1,
      bottom: 0,
      left: 0,
      right: 0,
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFC0BC9C),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/flower.png'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Text(
                  '디지털 추모관 입장 >',
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF121212),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
