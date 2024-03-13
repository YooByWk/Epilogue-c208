import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memorial_card.dart';
import 'memorial_list_viewmodel.dart';
class MemorialCardList extends StatefulWidget {
  @override
  _MemorialCardListState createState() => _MemorialCardListState();
}

class _MemorialCardListState extends State<MemorialCardList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    Provider.of<MemorialListViewModel>(context, listen: false).loadMemorialCards();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MemorialListViewModel>(
      builder: (context, viewModel, child) {
        return ListView.builder(
          controller: _scrollController,
          itemCount: viewModel.memorialCards.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(viewModel.memorialCards[index].title),
              leading: Image.asset(viewModel.memorialCards[index].imageUrl),
            );
          },
        );
      },
    );
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      Provider.of<MemorialListViewModel>(context, listen: false).loadMemorialCards();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}