import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_viewmodel.dart';
import 'package:frontend/screens/signup/signup_screen.dart';
 // provider 를 이용해 정리해야합니다.
 // 아무튼 그렇습니다.
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 97, 124, 119),
      // appBar: AppBar(
      //     // title: Text('Login'),
      //     ),
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

            SizedBox(height: 6),
            SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '아이디',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFececec),
                    ),
                  ),
                  // SizedBox(height: 4),
                  TextFormField(
                    onChanged: (value) {
                      // 여기에 입력함
                      LoginViewModel().setUsername(value);
                    },
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFececec),
                    ),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFececec)),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFececec)),
                      ),
                      // contentPadding: EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFFececec),
                ),
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  labelStyle: TextStyle(
                    color: Color(0xFFececec),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFececec)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFececec)),
                  ),
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
            SizedBox(height: 12),

            ElevatedButton(
              // 일반 로그인 버튼
              onPressed: () {
                LoginViewModel().login();
              },
              child: Text('로그인'),
            ),
            SizedBox(height: 5),

            Text(
              '------------------or------------------',
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            SizedBox(height: 7),

            Row(
              // BEGIN: Row
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  // 구글 로그인 버튼 : 추후 수정 예정
                  onPressed: () {},
                  child: Text('구글 로그인'),
                ),
                ElevatedButton(
                  // 네이버 로그인 버튼 : 추후 수정 예정
                  onPressed: () {},
                  child: Text('네이버 로그인'),
                ),
              ElevatedButton(
                // 카카오 로그인 버튼 : 추후 수정 예정
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Text('다음 페이지'),
              ),
              ],
            ), // END: Row
          ],
        ),
      ),
    );
  }
}
