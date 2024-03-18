import 'package:flutter/material.dart';

class MemorialDetailViewModel extends ChangeNotifier {

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
