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
  late final MemorialListViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = MemorialListViewModel();
    _viewModel.getLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MemorialAppBar(
        screenName : '디지털 추모관',
        colour : 'themeColour2'
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
                  // MemorialSearchWidget(viewModel: _viewModel),
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