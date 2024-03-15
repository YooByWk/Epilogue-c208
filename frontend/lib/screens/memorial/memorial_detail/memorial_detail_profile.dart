import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_widgets.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:provider/provider.dart';

class MemorialProfile extends StatelessWidget {

  final String? userName;
  final int? index;
  // final MemorialDetailViewModel _viewModel;

  const MemorialProfile({
    this.userName,
    this.index,
    super.key
    });
//  viewModel = MemorialDetailViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemorialDetailViewModel(userName: userName ?? ''), 
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
                      CommonText(text:  userName ?? '',  fontSize: 20, isBold: true),
                      // Text('추모관 이름 : $userName'),
                      Text('추모관 인덱스 : $index')
                    ]
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Text('1234.10.10 ~ 9999.09.09'),
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