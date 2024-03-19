class MemorialDetailModel {
  final String memorialName;
  String imagePath;
  final DateTime birthDate;
  final DateTime deathDate;
  // final String profileImage;
  final String userId;

  MemorialDetailModel({
    required this.memorialName,
    this.imagePath = '',
    required this.birthDate,
    required this.deathDate,
    // required this.profileImage,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
        'memorialName': memorialName,
        'imagePath': imagePath,
        'birthDate': birthDate,
        'deathDate': deathDate,
        // 'profileImage': profileImage,
        'userId': userId,
      };

  


 // fromJson도 구현하자.

// // 아직 사용되지 않습니다. -  MemorialDetail이라는 객체를 생성합니다.
// factory MemorialDetailModel.fromJson(Map<String, dynamic> json) { }
}
