class MemorialDetailModel {
  final String memorialName;
  String imagePath;
  final String birthDate;
  final String deathDate;
  // final String profileImage;
  final String memorialDate;
  final String userName;


MemorialDetailModel ({
  required this.memorialName,
   this.imagePath = '',
  required this.birthDate,
  required this.deathDate,
  // required this.profileImage,
  required this.memorialDate,
  required this.userName,
});

Map<String, dynamic> toJson() => {
  'memorialName': memorialName,
  'imagePath': imagePath,
  'birthDate': birthDate,
  'deathDate': deathDate,
  // 'profileImage': profileImage,
  'memorialDate': memorialDate,
  'userName': userName,
};


// // 아직 사용되지 않습니다. -  MemorialDetail이라는 객체를 생성합니다.
// factory MemorialDetailModel.fromJson(Map<String, dynamic> json) { }
}