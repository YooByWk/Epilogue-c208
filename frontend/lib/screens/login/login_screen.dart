import 'package:flutter/material.dart';
import 'package:frontend/screens/login/login_viewmodel.dart';
import 'package:frontend/screens/signup/signup_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      backgroundColor: Color(0xFF617C77),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                      TextFormField(
                        onChanged: (value) {
                          loginViewModel.setUsername(value);
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
                        ),
                      ),
                    ],
                  ),
                ),
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
                    onChanged : (value) => loginViewModel.setPassword(value),
                  ),
                ),
                SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    loginViewModel.login();
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
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUpScreen(),
                          ),
                        );
                      },
                      child: Text('다음 페이지'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
              bottom: 10,
              left: 0,
              right:0,
              child: !loginViewModel.isFocused?  Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/flower.png'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Text('디지털 추모관 입장 >',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFFececec),
                      ))
                ]),
              ) : Container()
              ),
        ],
      ),
    );
  }
}
