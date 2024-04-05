import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_list_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';

class MemorialCard extends StatelessWidget {
// 글자수 길면 잘라버리기

  String _formatText(String text) {
    const int maxCharsPerLine = 9;
    // 전체 텍스트를 rune 단위로 처리하여, 각 문자를 정확히 카운트합니다.
    List<int> runes = text.runes.toList();

    // 첫 번째 줄 처리: 최대 7자까지 허용
    String firstLine = runes.length > maxCharsPerLine
        ? String.fromCharCodes(runes.take(maxCharsPerLine))
        : String.fromCharCodes(runes);

    // 두 번째 줄 처리: 남은 텍스트가 있을 경우, 처리
    String secondLine = runes.length > maxCharsPerLine
        ? (runes.length <= maxCharsPerLine * 2
        ? String.fromCharCodes(runes.getRange(maxCharsPerLine, runes.length))
        : String.fromCharCodes(runes.getRange(maxCharsPerLine, maxCharsPerLine * 2)) + '...')
        : '';

    // 두 문자열을 조합하여 최종 텍스트 생성
    return firstLine + (secondLine.isNotEmpty ? '\n$secondLine' : '');
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
            text: _formatText('$graveName'),
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
          Positioned(
            top: 25,
            child: IconButton(
              iconSize: 30,
              icon:  viewModel.favoriteMemorialList.any((favorite) => favorite.graveSeq == graveSeq) ? Icon(Icons.star) : Icon(Icons.star_border),
              onPressed: () {
                _storage.write(key: 'favoriteMemorial', value: graveSeq.toString());
                viewModel.favoriteMemorial().then((_) {
                  if (viewModel.errorMessage ==
                      null) {
                  }
                });
              },
            ),
          ),
          Positioned(
              bottom: 30,
              child: Text('故$name', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
          ),
        ],
      ),
    );
  }

}

