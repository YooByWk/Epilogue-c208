import 'package:flutter/material.dart';
import 'package:frontend/screens/signup/signup_input_widget.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF617C77),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 45),
            SizedBox(
              height: 100,
              child: Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 10),
            SignUpInput(label: '이름'),
            SizedBox(height: 10),
            SignUpInput(label: '생년월일'),
            SizedBox(height: 10),
            SignUpInput(label: '휴대폰 번호'),
            SizedBox(height: 10),
            SignUpInput(label: '아이디'),
            SizedBox(height: 10),
            SignUpInput(label: '비밀번호', obscureText: true),
            SizedBox(height: 10),
            SignUpInput(label: '비밀번호 확인'),
            SizedBox(height: 10),
            SizedBox(
              width: 342,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // 회원가입 버튼 클릭 시 처리
                },
                child: Text(
                  '회원가입',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
