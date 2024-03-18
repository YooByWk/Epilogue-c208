import 'package:flutter/material.dart';
import 'package:frontend/models/memorial_model.dart';

class MemorialDetailViewModel extends ChangeNotifier {
  late MemorialDetailModel _model;
  late String _imagePath;

  

  final String userName;
  late String _imagePath;
  MemorialDetailViewModel({required this.userName}) {
  _imagePath = 'https://source.unsplash.com/user/$userName/300×300';
  }


  String get imagePath => _imagePath;

  void setProfileImage(String newPath) {
    _imagePath = newPath;
    debugPrint('Image changed to $_imagePath');
    notifyListeners();
  }
}
