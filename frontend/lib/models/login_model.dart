class LoginModel {
  final String userId;
  final String password;

  LoginModel({
    required this.userId,
    required this.password,

     });

  // 현재 단계에서 필요하지 않은 코드
  // factory LoginModel.fromJson(Map<String, dynamic> json) {
  //   return LoginModel(
  //     email: json['email'],
  //     password: json['password'],
  //   );
  // }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'password': password,
  };
}

