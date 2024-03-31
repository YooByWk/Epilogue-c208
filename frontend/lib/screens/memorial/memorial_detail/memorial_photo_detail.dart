import 'package:flutter/material.dart';
import 'package:frontend/screens/memorial/memorial_app_bar.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_photo_detail_viewmodel.dart';
import 'package:provider/provider.dart';

class MemorialPhotoDetailScreen extends StatelessWidget {
  const MemorialPhotoDetailScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemorialPhotoDetailViewModel(),
      child: Consumer<MemorialPhotoDetailViewModel>(
        builder: (context, viewModel, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>?;
          final index = args?['index'] ?? '인덱스';

          return Scaffold(
              appBar: MemorialAppBar(
                screenName: '세월은 가도 사진은 남는다',
                isMenu: true,
                items: ['회원가입', '로그인', '로그아웃'],
                onSelected: (value) {
                  debugPrint('$value 선택됨');
                },
                // screenName: '추모관상세',
              ),
              body: viewModel.isLoading
                  ? Center(
                      child: CircularProgressIndicator(), // 로딩 중 표시
                    )
                  : Center(
                      child: Column(
                        children: [
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
