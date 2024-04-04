import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_body.dart'; // memorial body widget import
import 'package:frontend/screens/memorial/memorial_topbtn.dart';
import 'package:frontend/screens/memorial/memorial_widgets.dart'; // memorial image widget import
import 'package:frontend/screens/memorial/memorial_card.dart';
import 'package:frontend/screens/memorial/memorial_list_viewmodel.dart'; // Import the ViewModel

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
    _scrollController.addListener(_onScroll);
    _viewModel.loadMore();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    debugPrint('스크롤 감지' + _scrollController.position.pixels.toString());
    debugPrint('현재 Item 수: ' + _viewModel.memorialCards.length.toString());
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _viewModel.loadMore();
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: themeColour2,
      title: Text('디지털 추모관'),
    ),
    body: CustomScrollView(
      controller: _scrollController,
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Stack(
                  children: [
                    MemorialImage(),
                    MemorialBody(),
                  ],
                ),
              ),
              MemorialSearchWidget(),
            ],
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Set the number of items in a row
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return MemorialCard(imagePath: _viewModel.memorialCards[index]);
            },
            childCount: _viewModel.memorialCards.length,
          ),
        ),
      ],
    ),
    floatingActionButton: ScrollToTopBtn(scrollController: _scrollController),
  );
}
}