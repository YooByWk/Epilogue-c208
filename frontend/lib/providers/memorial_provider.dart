import 'package:flutter/material.dart';

class SelectedPostProvider with ChangeNotifier {
  int? _selectedMemorialId;

  int? get selectedMemorialId => _selectedMemorialId;

  void setSelectedMemorialId(int memorialId) {
    _selectedMemorialId = memorialId;
    notifyListeners();
  }
}
