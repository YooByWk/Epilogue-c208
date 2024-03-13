import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_body.dart'; // memorial body widget import
import 'package:frontend/screens/memorial/memorial_widgets.dart'; // memorial image widget import

import 'package:frontend/screens/memorial/memorial_list.dart';

class MemorialScreen extends StatelessWidget {
  @override

Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColour2,
        title: Text('디지털 추모관'),
      ),
      body: Column(
        children: [
          Stack(
            children: [
              MemorialImage(),
              MemorialBody(),
            ],
          ),
          MemorialSearchWidget(),
          Expanded(
            child: MemorialList(),
          ),
        ]
      ));
}
}
