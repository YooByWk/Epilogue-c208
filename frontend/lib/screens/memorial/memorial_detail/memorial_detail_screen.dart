import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_app_bar.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_tabBar.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_widgets.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_profile.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_viewmodel.dart';
import 'package:provider/provider.dart';

class MemorialDetailScreen extends StatelessWidget {
  const MemorialDetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemorialDetailViewModel(),
      child: Consumer<MemorialDetailViewModel>(
        builder: (context, viewModel, child) {

          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeColour2,
              title: Text('故 ${viewModel.memorialDetailModel?.name}님의 추모관'),
            ),
            body: viewModel.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : viewModel.errorMessage != null
                    ? Center(child: Text(viewModel.errorMessage!))
                    : NestedScrollView(
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverList(
                              delegate: SliverChildListDelegate([
                                Container(
                                  child: MemorialProfile(
                                    viewModel: viewModel,
                                  ),
                                ),
                              ]),
                            )
                          ];
                        },
                        body: MemorialDetailTabBar(),
                      ),
          );
        },
      ),
    );
  }
}