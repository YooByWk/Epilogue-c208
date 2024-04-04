//memorial_detail_letter_tab.dart
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_letter_upload.dart';
import 'package:frontend/view_models/dio_api_request_examples.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_letterTab_viewmodel.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:provider/provider.dart';

class LetterTab extends StatefulWidget {
  const LetterTab({Key? key}) : super(key: key);

  @override
  _LetterTabState createState() => _LetterTabState();
}

class _LetterTabState extends State<LetterTab> {
  final List<Color> colorList = [
    Color.fromRGBO(255, 245, 192, 1.0),
    Color.fromRGBO(197, 255, 192, 1.0),
    Color.fromRGBO(192, 213, 255, 1.0),
    Color.fromRGBO(246, 192, 255, 1.0),
    Color.fromRGBO(255, 215, 192, 1.0),
  ];


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LetterTabViewModel(),
        child: Consumer<LetterTabViewModel>(
          builder: (context, viewModel, child) {
            return NotificationListener<ScrollNotification>(
                onNotification: (scroll) {
                  if (!viewModel.isLoading && scroll.metrics.pixels >=
                      scroll.metrics.maxScrollExtent - 50) {
                    viewModel.loadMore();
                  }
                  return false;
                },
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1 / 0.8,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          if (index == 0) {
                            return Card(
                                child: InkWell(
                              onTap: () async {
                                bool res = await Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>MemorialLetterUpload()),
                                );
                                if (res == true) {
                                  viewModel.loadInitialData();
                                  debugPrint('편지 추가 확인${viewModel.letters.length}');
                                  // setState((){});
                                } 
                              },
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add),
                                    Text(
                                      '편지 추가',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  ]),
                            ));
                          } else {
                            Color cardColor =
                                colorList[(index - 1) % colorList.length];

                            return Letter(
                              key: ValueKey(viewModel
                                  .letters[index - 1].memorialLetterSeq),
                              content:
                                  (viewModel.letters[index - 1].content != null)
                                      ? viewModel.letters[index - 1].content
                                      : '',
                              date: viewModel.letters[index - 1].writtenDate,
                              nickname: viewModel.letters[index - 1].nickname,
                              cardColor: cardColor,
                              // memorialLetterSeq: viewModel.letters[index - 1].memorialLetterSeq.toString(),
                            );
                          }
                        },
                        childCount: viewModel.letters.length + 1,
                      ),
                    )
                  ],
                ));
          },
        ));
  }
}

class Letter extends StatelessWidget {
  final String? nickname;
  final String? content;
  final String date;
  final Color cardColor;

  // final int memorialLetterSeq;

  Letter({
    Key? key,
    this.nickname,
    this.content,
    required this.date,
    required this.cardColor,
    // required this.memorialLetterSeq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayNickname = nickname ?? '';
    if (displayNickname.length > 6) {
      displayNickname = '${displayNickname.substring(0, 6)}...';
    }

    String displayContent = content ?? '';
    if (displayContent.length > 30) {
      displayContent = '${displayContent.substring(0, 30)}...';
    }
    OverlayEntry? overlayEntry;
    return Card(
      color: cardColor,
      child: GestureDetector(
        onLongPress: () {
        },
        onLongPressEnd: (details) {
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("From. $displayNickname", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(displayContent, style: TextStyle(fontSize: 20)),
              Text(date, style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}


