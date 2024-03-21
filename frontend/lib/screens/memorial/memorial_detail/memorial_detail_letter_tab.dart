import 'package:flutter/material.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_letterTab_viewmodel.dart';
import 'package:provider/provider.dart';

class LetterTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LetterViewModel(),
        child: Consumer<LetterViewModel>(
          builder: (context, viewModel, child) {
            return NotificationListener<ScrollNotification>(
                onNotification: (scroll) {
                  if (scroll.metrics.pixels >=
                      scroll.metrics.maxScrollExtent - 50) {
                    viewModel.loadMore();
                    debugPrint('더 불러오기');
                    debugPrint(viewModel.letters.length.toString());
                  } else {
                    debugPrint('스크롤 위치 ${scroll.metrics.pixels}');}
                  return false;
                },
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 2,
                      ),
                      delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        if (index == 0) {
                          return Card(
                              child: InkWell(
                            onTap: () => {debugPrint('$index')},
                            child: Column(
                                children: [Icon(Icons.add), Text('편지 추가')]),
                          ));
                        } else {
                          debugPrint(viewModel.letters.length.toString());
                          return Letter(
                            key: ValueKey(index),
                            title: '제목' + viewModel.letters[index].title,
                            content: '내용' + viewModel.letters[index].content,
                            date: viewModel.letters[index].date,
                            userId: 'a' + viewModel.letters[index].userId,
                            index: index,
                          );
                        }
                      }
                      ,childCount: viewModel.letters.length,
                      ),
                    )
                  ],
                ));
          },
        ));
  }
}

class Letter extends StatelessWidget {
  final String title;
  final String content;
  final DateTime date;
  final String userId;
  final int index;

  Letter({
    Key? key,
    required this.title,
    required this.content,
    required this.date,
    required this.userId,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OverlayEntry? overlayEntry;
    return Card(
      child: GestureDetector(
        onLongPress: () {
          overlayEntry = OverlayEntry(
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width * 0.1,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/letter.png'),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ),
            ),
          );
          Overlay.of(context)!.insert(overlayEntry!);
        },
        onLongPressEnd: (details) {
          overlayEntry?.remove();
        },
        child: Column(
          children: [
            Text(title),
            Text(content),
            Text(date.toString()),
            Text(userId),
          ],
        ),
      ),
    );
  }
}
