import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_card.dart';

class MemorialListViewModel extends ChangeNotifier {
  List<MemorialCard> _memorialCards = [];
  bool _isLoading = false;

  List<MemorialCard> get memorialCards => _memorialCards;
  bool get isLoading => _isLoading;

  void loadMemorialCards() async {
    if (_isLoading) return ;

    _isLoading = true;

    List<MemorialCard> newCards = await fetchCardsFromServer();
    _memorialCards.addAll(newCards);
    _isLoading = false;
    notifyListeners();
  }

  Future<List<MemorialCard>> fetchCardsFromServer() async {

    return List.generate(
      10,
      (index) => MemorialCard(
        title: 'Card ${_memorialCards.length + index + 1}',
        imageUrl: 'assets/images/ameno.jpg',
        route: '/memorial/$index'
      ),
    );
  }
}