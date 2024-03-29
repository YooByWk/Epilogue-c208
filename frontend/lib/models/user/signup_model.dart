class SignupModel {
  final String userId; // 사용자의 고유한 아이디, 이메일 혹은 전화번호로 사용자를 식별하는데 사용
  final String password; // 사용자의 비밀번호
  final String name; // 사용자의 이름
  final String mobile; // 사용자의 전화번호
  final String birth; // 사용자의 생년월일
  final String certificationNumber; // 휴대폰 인증 번호

  SignupModel({
    required this.userId,
    required this.password,
    required this.name,
    required this.mobile,
    required this.birth,
    required this.certificationNumber,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) {
    return SignupModel(
      userId: json['userId'],
      password: json['password'],
      name: json['name'],
      mobile: json['mobile'],
      birth: json['birth'],
      certificationNumber: json['certification']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'password': this.password,
      'name': this.name,
      'mobile': this.mobile,
      'birth': this.birth,
      'certificationNumber': this.certificationNumber,
    };
  }
}