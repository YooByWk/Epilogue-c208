import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_main/memorial_card.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_list_viewmodel.dart';

class MemorialGrid extends StatelessWidget {
  final MemorialListViewModel viewModel;
  final int gridCount;

  MemorialGrid({
    required this.viewModel,
    this.gridCount = 2,
  });

  @override
  Widget build(BuildContext context) {
    return

      viewModel.searchList.isEmpty
        ?
    SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCount,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (index < viewModel.favoriteMemorialList.length) {
                  final memorial = viewModel.favoriteMemorialList[index];

                  return MemorialCard(
                    // imagePath: memorial.graveImg,
                    graveSeq: memorial.graveSeq,
                    name: memorial.name,
                    graveName: memorial.graveName,
                    viewModel: viewModel,
                  );
                } else {
                  final memorial = viewModel.memorialList[
                      index - viewModel.favoriteMemorialList.length];
                  return MemorialCard(
                    // imagePath: memorial.graveImg,
                    viewModel: viewModel,
                    graveSeq: memorial.graveSeq,
                    name: memorial.name,
                    graveName: memorial.graveName,
                  );
                }
              },
              childCount: viewModel.favoriteMemorialList.length +
                  viewModel.memorialList.length,
            ))
        : SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridCount,
            ),
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              final memorial = viewModel.searchList[index];
              return MemorialCard(
                // imagePath: memorial.graveImg,
                viewModel: viewModel,
                graveSeq: memorial.graveSeq,
                name: memorial.name,
                graveName: memorial.graveName,
              );
            }, childCount: viewModel.searchList.length),
          );
  }
}
