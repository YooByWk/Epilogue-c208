import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_viewmodel.dart';

class MemorialProfileWidget extends StatelessWidget {

  final String? userName;
  final int? index;

  const MemorialProfileWidget({
    this.userName,
    this.index,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MemorialProfileImage(),
            Column(
              
              children : <Widget>[
                Text('추모관 이름 : $userName'),
                Text('추모관 인덱스 : $index')
              ]
            )
          ],
        ),
        SizedBox(height: 20.0),
        Text('1234.10.10 ~ 9999.09.09')
      ]
    );
  }
}