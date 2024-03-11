import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_viewmodel.dart';



class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 97, 124, 119),
      appBar: AppBar(
          // title: Text('Login'),
          ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Text(
            //   'E:pilogue',
            //   style: TextStyle(fontSize: 45),
            // ),
            Container(
              width: 300,
              height: 125,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            
            // Image.asset('assets/images/logo.png'),

            SizedBox(height: 16),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: '아이디',
                  
                ),
              ),
            ),

            SizedBox(height: 16),

            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                style: TextStyle(
                  fontSize: 20,
                ),
                decoration: InputDecoration(
                  labelText: '비밀번호',
                ),
                obscureText: true,
              ),
            ),

            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: '비밀번호',
            //   ),
            //   obscureText: true,
            // ),
            SizedBox(height: 20),

            ElevatedButton( // 일반 로그인 버튼
              onPressed: () {
                LoginViewModel().login();
                // TODO: Implement login logic
              },
              child: Text('로그인'),
            ),
            SizedBox(height: 20),

            Text(
              '------------------or------------------',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 20),

            Row(
              // BEGIN: Row
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton( // 구글 로그인 버튼 : 추후 수정 예정
                  onPressed: () {},
                  child: Text('구글 로그인'),
                ),
                ElevatedButton( // 네이버 로그인 버튼 : 추후 수정 예정
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
