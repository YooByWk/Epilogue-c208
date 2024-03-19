class UserModel {
  final String id; // 사용자의 고유한 아이디, 이메일 혹은 전화번호로 사용자를 식별하는데 사용
  final String email; // 사용자의 이메일 주소
  final String password; // 사용자의 비밀번호
  final String name; // 사용자의 이름
  final String phoneNumber; // 사용자의 전화번호
  final DateTime birthDate; // 사용자의 생년월일

  UserModel({
    required this.id,
    required this.email,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.birthDate,
  });
 
  UserModel copyWith({
    String? id,
    String? email,
    String? password,
    String? name,
    String? phoneNumber,
    DateTime? birthDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
    );
  
  }
  // 사용 예시
  // UserModel updatedUser = currentUser.copyWith(email: 'new-email@example.com');

  Future <void> fetchUserDate() async {
    // 사용자의 데이터를 가져오는 비동기 함수 작성 예정

  }
}