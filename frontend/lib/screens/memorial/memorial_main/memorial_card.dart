import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:provider/provider.dart';

class MemorialCard extends StatelessWidget {
  final _storage = FlutterSecureStorage();
  // final String imagePath;
  final int graveSeq;

  // final String userText;
  final String name;
  final String graveName;

  MemorialCard({
    // required this.imagePath,
    // required this.routes,
    // required this.userText,
    required this.graveSeq,
    required this.name,
    required this.graveName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CommonButtonWidget(
            height: 300,
            width: 300,
            text: '$graveName\n故$name',
            fontSize: 24,
            textColor: Colors.black,
            imagePath: 'assets/images/stone.png',
            onPressed: () {
              _storage.write(key: 'graveSeq', value: graveSeq.toString());
              Navigator.pushNamed(context, '/memorialDetail', arguments: {
                'index': graveSeq,
                'memorialName': name,
              });
            },
          ),
          Positioned(
            top: 25,
            child: IconButton(
              iconSize: 30,
              icon: Icon(Icons.star_border),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

}

