// memorial_screen.dart
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_app_bar.dart';
import 'package:frontend/screens/memorial/memorial_grid.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_list_viewmodel.dart';
import 'package:frontend/screens/memorial/memorial_topbtn.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_body.dart';
import 'package:frontend/screens/memorial/memorial_widgets.dart';

class MemorialScreen extends StatefulWidget {
  
  @override
  _MemorialScreenState createState() => _MemorialScreenState();
}

class _MemorialScreenState extends State<MemorialScreen> {
  final ScrollController _scrollController = ScrollController();
  final MemorialListViewModel _viewModel = MemorialListViewModel();

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_onScroll);
    _viewModel.getLists();
  }

  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  // void _onScroll() {
  //   // debugPrint('스크롤 감지' + _scrollController.position.pixels.toString());
  //   if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 50) {
  //     debugPrint('현재 Item 수: ' + _viewModel.memorialCards.length.toString() + '새로운 정보를 불러옵니다.');
  //     _viewModel.loadMore();
  //
  //     setState((){}); // Update the UI
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MemorialAppBar(
        screenName : '디지털 추모관',
        colour : 'themeColour'
      ),
      body: Container(
        color: backgroundColour, // Set the background color here
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  MemorialBodyWidget(),
                  MemorialSearchWidget(),
                ],
              ),
            ),
            MemorialGrid(viewModel: _viewModel),
          ],
        ),
      ),
      floatingActionButton: ScrollToTopBtn(scrollController: _scrollController),
    );
  }
}