import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_list_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';

class MemorialCard extends StatelessWidget {
// 글자수 길면 잘라버리기
  String _truncateText(String text, int maxLines) {
    final span = TextSpan(text: text);
    final tp = TextPainter(
      text: span,
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    );

    tp.layout();

    if (tp.didExceedMaxLines) {
      final endIndex = tp.getPositionForOffset(Offset(0, tp.height)).offset;
      return text.substring(0, endIndex - 3) + '...';
    } else {
      return text;
    }
  }

  final _storage = FlutterSecureStorage();
  // final String imagePath;
  final int graveSeq;

  // final String userText;
  final String name;
  final String graveName;

  final MemorialListViewModel viewModel;

  MemorialCard({
    // required this.imagePath,
    // required this.routes,
    // required this.userText,
    required this.viewModel,
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
            text: _truncateText('$graveName', 2),
            fontSize: 15,
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
          // Positioned(
          //   top: 25,
          //   child: IconButton(
          //     iconSize: 30,
          //     // icon:  viewModel.favoriteMemorialList.any((favorite) => favorite.graveSeq == graveSeq) ? Icon(Icons.star) : Icon(Icons.star_border),
          //     onPressed: () {
          //       _storage.write(key: 'favoriteMemorial', value: graveSeq.toString());
          //       viewModel.favoriteMemorial().then((_) {
          //         if (viewModel.errorMessage ==
          //             null) {
          //         }
          //       });
          //       },
          //   ),
          // ),
          Positioned(
            bottom: 30,
            child: Text('故$name', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
          ),
        ],
      ),
    );
  }

}

