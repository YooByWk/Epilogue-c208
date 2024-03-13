import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_card.dart';
import 'package:frontend/screens/memorial/memorial_list_viewmodel.dart'; // Import the ViewModel

class MemorialList extends StatefulWidget {
  @override
  _MemorialListState createState() => _MemorialListState();
}

class _MemorialListState extends State<MemorialList> {
  final ScrollController _scrollController = ScrollController();
  final MemorialListViewModel _viewModel = MemorialListViewModel();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _viewModel.loadMore();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    debugPrint('Current scroll position: ${_scrollController.position.pixels}'); // Print the current scroll position
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
      debugPrint('스크롤 완료'); // Print a message when the scroll reaches the end
      _viewModel.loadMore();
    }
  }

Widget build(BuildContext context) {
  return ListView.builder(
    controller: _scrollController,
    itemCount: _viewModel.memorialCards.length,
    itemBuilder: (context, index) {
      return MemorialCard(imagePath: _viewModel.memorialCards[index]);
    },
    // other properties...
  );
}

}