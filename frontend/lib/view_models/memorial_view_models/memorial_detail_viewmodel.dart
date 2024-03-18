import 'package:flutter/material.dart';
import 'package:frontend/models/memorial_detail_model.dart';

class MemorialDetailViewModel extends ChangeNotifier {
  late MemorialDetailModel _model;

  MemorialDetailViewModel({
    required String memorialName, // 추모관 이름
    String imagePath = '', // 이미지 경로
    required String userId, // 유저명
    required DateTime birthDate, //  출생일
    required DateTime deathDate, //   기일
  }) {
    _model = MemorialDetailModel(
      memorialName: memorialName,
      imagePath: 'https://source.unsplash.com/user/$userId/300×300',
      birthDate: birthDate,
      deathDate: deathDate,
      userId: userId,
    );
  }

  String get memorialName => _model.memorialName;
  String get imagePath => _model.imagePath;
  DateTime get birthDate => _model.birthDate;
  DateTime get deathDate => _model.deathDate;
  String get userId => _model.userId;

  // // Model의 값 변화용 함수 - 하지만 추모관의 정보는 변경 될 일이 별로 없는데?
  // void updateModel({
  //   String? memorialName,
  //   String? imagePath,
  //   DateTime? birthDate,
  //   DateTime? deathDate,
  //   String? userId,
  // }) {
  //   if (memorialName != null) {
  //     _model.memorialName = memorialName;
  //   }
  //   if (imagePath != null) {
  //     _model.imagePath = imagePath;
  //   }
  //   if (birthDate != null) {
  //     _model.birthDate = birthDate;
  //   }
  //   if (deathDate != null) {
  //     _model.deathDate = deathDate;
  //   }
  //   if (userId != null) {
  //     _model.userId = userId;
  //   }
  //   notifyListeners();
  // }

  /* 사용예시
viewModel.updateModel(
  memorialName: 'New Name',
  birthDate: DateTime.now(),
);
 */


//   MemorialDetailViewModel({required this.userName}) {
//     _imagePath = 'https://source.unsplash.com/user/$userName/300×300';
//   }

//   String get imagePath => _imagePath;

//   void setProfileImage(String newPath) {
//     _imagePath = newPath;
//     debugPrint('Image changed to $_imagePath');
//     notifyListeners();
//   }
// }
}