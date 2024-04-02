// memorial_screen.dart
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_app_bar.dart';
import 'package:frontend/screens/memorial/memorial_grid.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_list_viewmodel.dart';
import 'package:frontend/screens/memorial/memorial_topbtn.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_body.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:provider/provider.dart';

import '../memorial_widgets.dart';

class MemorialScreen extends StatefulWidget {
  @override
  _MemorialScreenState createState() => _MemorialScreenState();
}

class _MemorialScreenState extends State<MemorialScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MemorialListViewModel(),
        child: Consumer<MemorialListViewModel>(
            builder: (context, viewModel, child) {
          return Scaffold(
            appBar:
                MemorialAppBar(screenName: '디지털 추모관', colour: 'themeColour2'),
            body: viewModel.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    color: backgroundColour, // Set the background color here
                    child: CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              MemorialBodyWidget(),
                              MemorialSearchWidget(viewModel: viewModel),
                            ],
                          ),
                        ),
                        MemorialGrid(viewModel: viewModel),
                      ],
                    ),
                  ),
            floatingActionButton:
                ScrollToTopBtn(scrollController: _scrollController),
          );
        }));
  }
}
