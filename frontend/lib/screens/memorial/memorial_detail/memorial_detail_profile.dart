import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/models/memorial_detail_model.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_widgets.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_viewmodel.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:provider/provider.dart';

class MemorialProfile extends StatelessWidget {
  final MemorialDetailViewModel viewModel;

  MemorialProfile({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          MemorialProfileImage(imagePath: viewModel.memorialDetailModel!.graveImg),
          // Text('프로필 이미지'),
          Column(children: <Widget>[
            CommonText(
                text: '故 ${viewModel.memorialDetailModel!.name}',
                fontSize: 30,
                isBold: true),
      Text(
          '${viewModel.memorialDetailModel!.birth} ~ ${viewModel.memorialDetailModel!.goneDate}',
      style: TextStyle(fontSize: 16),),
          ])
        ],
      ),
      SizedBox(height: 20.0),
      Divider(
        height: 20.0,
        color: Colors.grey,
      ),
    ]);
  }
}
