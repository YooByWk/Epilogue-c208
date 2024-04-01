import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_app_bar.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_photo_detail_viewmodel.dart';
import 'package:frontend/widgets/popup_widget.dart';
import 'package:provider/provider.dart';

class MemorialPhotoDetailScreen extends StatelessWidget {
  const MemorialPhotoDetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemorialPhotoDetailViewModel(),
      child: Consumer<MemorialPhotoDetailViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: themeColour2,
                title: Text('세월은 가도 사진은 남는다.'),
              ),
              body: viewModel.isLoading
                  ? Center(
                      child: CircularProgressIndicator(), // 로딩 중 표시
                    )
                  : Center(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('게시물 신고하기'),
                                    content: Text('게시물을 신고하시겠습니까?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('취소'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          viewModel.reportPhoto().then((_) {
                                            if (viewModel.errorMessage ==
                                                null) {
                                              Navigator.of(context).pop();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text('신고가 완료되었습니다'),
                                                ),
                                              );
                                            }
                                          });
                                        },
                                        child: Text('신고'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('게시물 신고하기'),
                          ),
                          Image.network(
                              viewModel.memorialPhotoDetailModel!.s3url),
                          Text(viewModel.memorialPhotoDetailModel!.content!),
                        ],
                      ),
                    ));
        },
      ),
    );
  }
}
