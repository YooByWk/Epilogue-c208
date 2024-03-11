import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_viewmodel.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'E:pilogue',
              style: TextStyle(fontSize: 45),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: '아이디',
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: '비밀번호',
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement login logic
              },
              child: Text('로그인'),
            ),
            Text(
              '------------------or------------------',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 16),
            Row(
              // BEGIN: Row
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('구글 로그인'),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('네이버 로그인'),
                ),
              ],
            ), // END: Row
          ],
        ),
      ),
    );
  }
}
