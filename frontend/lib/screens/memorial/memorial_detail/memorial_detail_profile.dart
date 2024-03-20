import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_widgets.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:provider/provider.dart';

class MemorialProfile extends StatelessWidget {

  final String? memorialName;
  final int? index;
  // final MemorialDetailViewModel _viewModel;

  const MemorialProfile({
    this.memorialName,
    this.index,
    super.key
    });
//  viewModel = MemorialDetailViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemorialDetailViewModel(
        memorialName : memorialName ?? '',
        userId : '사용자 명이 들어갈 예정;',
        birthDate : DateTime.now(),
        deathDate : DateTime(DateTime.now().year + Random().nextInt(100), DateTime.now().month, DateTime.now().day),
      ), 
      child : Consumer<MemorialDetailViewModel>(
        builder : (context, viewModel, child) {
          return Column(
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  MemorialProfileImage(imagePath: viewModel.imagePath),
                  // Text('프로필 이미지'),
                  Column(
                    children : <Widget>[
                      CommonText(text:  memorialName ?? '',  fontSize: 20, isBold: true),
                      // Text('추모관 이름 : $userName'),
                      Text('추모관 인덱스 : ${index != null ? (int.parse(index.toString()) + 1).toString() : index.toString()} ')
                    ]
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Text('${viewModel.birthDate.year}.${viewModel.birthDate.month}.${viewModel.birthDate.day} ~ ${viewModel.deathDate.year}.${viewModel.deathDate.month}.${viewModel.deathDate.day}'),
              Divider(
                height: 20.0,
                color: Colors.grey,
              ),
            ]
          );
        }
      )
    );
    
  }
}
    //  Column(
    //   children: <Widget>[
    //     SizedBox(height: MediaQuery.of(context).size.height * 0.03),
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //       children: <Widget>[
    //         MemorialProfileImage(),
    //         Text('프로필 이미지'),
    //         Column(
    //           children : <Widget>[
    //             Text('추모관 이름 : $userName'),
    //             Text('추모관 인덱스 : $index')
    //           ]
    //         )
    //       ],
    //     ),
    //     SizedBox(height: 20.0),
    //     Text('1234.10.10 ~ 9999.09.09'),
    //     Divider(
    //       height: 20.0,
    //       color: Colors.grey,
    //     ),
    //   ]
    // );