import 'package:flutter/material.dart';

class MemorialListViewModel extends ChangeNotifier {
  List<String> _memorialCards = [];
  int _nextItem = 0;

  List<String> get memorialCards => _memorialCards;


  void loadMore() {
    // Add more items to the list
      debugPrint('Added item $_nextItem');
    for (int i = 0; i < 20; i++) {
      _memorialCards.add('assets/images/ameno.jpg');
      _nextItem++;
    }
    notifyListeners(); // Notify listeners to update the UI
  }
}