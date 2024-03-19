// memorial_grid.dart
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
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Set the number of items in a row
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return MemorialCard(
            imagePath: viewModel.memorialCards[index],
            index: index,
            memorialName: '추모관 이름 ' + index.toString(),
          );
        },
        childCount: viewModel.memorialCards.length,
      ),
    );
  }
}