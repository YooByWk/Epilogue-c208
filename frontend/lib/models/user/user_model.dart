class UserModel {
  final String userId;
  String name;
  String mobile;
  final String birth;

  UserModel({
    required this.userId,
    required this.name,
    required this.mobile,
    required this.birth,
  });

  UserModel copyWith({
    String? userId,
    String? name,
    String? mobile,
    String? birth,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
      birth: birth ?? this.birth,
    );
  }

  // JSON에서 UserModel 인스턴스로의 변환 생성자
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      mobile: json['mobile'],
      birth: json['birth'],
    );
  }

  // UserModel 인스턴스에서 JSON으로의 변환 메서드
  Map<String, dynamic> toJson() {
    return {
      'userId': this.userId,
      'name': this.name,
      'mobile': this.mobile,
      'birth': this.birth,
    };
  }
}
