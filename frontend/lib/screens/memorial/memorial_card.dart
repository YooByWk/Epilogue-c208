import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_detail_screen.dart';

class MemorialCard extends StatelessWidget {
  final String imagePath;
  // final String routes;
  // final String userText;
  final int index;
  final String userName;
  MemorialCard({
    required this.imagePath,
    // required this.routes,
    // required this.userText,
    required this.index,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          // Navigator.pushNamed(context, 'memorial/\$index');
          debugPrint('클릭 인덱스 : $index, $userName');
          // Navigator.push(context, MaterialPageRoute(builder : (context) => MemorialDetailScreen(

          // )));
          Navigator.pushNamed(context, '/memorialDetail', arguments: {
            'index': index,
            'userName': userName,
          });
        //  arguments: {
        //    'index' : index,
        //    'userName' : userName,
        //    }
        //  );
        },
        child: Image.asset(imagePath),
      ),
    );
  }
}