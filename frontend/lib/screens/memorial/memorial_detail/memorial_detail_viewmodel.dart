import 'package:flutter/material.dart';

class MemorialDetailViewModel extends ChangeNotifier {
  String _imagePath = 'assets/images/memorial_test/portrait.png';

  String get imagePath => _imagePath;

  void setProfileImage() {
    _imagePath = imagePath;
    debugPrint('Image changed to $imagePath');
    notifyListeners();
  }
}
