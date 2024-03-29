import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_select_info_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/view_models/will_view_models/memorial_name_picture_viewmodel.dart';
import 'package:provider/provider.dart';

class WillEpitaphPictureScreen extends StatefulWidget {
  _WillEpitaphPictureScreenState createState() =>
      _WillEpitaphPictureScreenState();
}

class _WillEpitaphPictureScreenState extends State<WillEpitaphPictureScreen> {
  File? picture;

  Future<void> _pickImage(BuildContext context) async {
        FilePickerResult? result = await FilePicker.platform.pickFiles();

        if (result != null) {
          picture = File(result.files.single.path!);
        } else {
          debugPrint('사진 선택 취소');
        }
    }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MemorialNamePictureViewModel(),
        child: Consumer<MemorialNamePictureViewModel>(
            builder: (context, viewModel, child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: themeColour2,
                title: const Text('유언장 생성하기'),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: "추모관에 등록할",
                          fontSize: 50,
                          fontWeight: FontWeight.w500,
                        ),
                        Row(
                          children: [
                            TextWidget(
                              text: '묘비명',
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                            ),
                            TextWidget(
                              text: '과',
                              fontSize: 50,
                              fontWeight: FontWeight.w500,
                            ),
                            TextWidget(
                              text: '사진',
                              fontSize: 50,
                              fontWeight: FontWeight.w900,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: WillEpitaphWidget(
                      viewModel: viewModel,
                    ),
                  ),
                  Center(
                    child: WillCommonButtonWidget(
                      text: "사진 업로드",
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.11,
                      backgroundColor: Colors.white,
                      onPressed: () {
                        _pickImage(context);
                        viewModel.setFile(picture!);
                      },
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: SizedBox(
                width: double.infinity,
                height: 100,
                child: TextButtonWidget(
                  preText: '이전',
                  nextText: '다음',
                  onPressed: () {
                    viewModel
                        .setMemorial()
                        .then((_) => debugPrint('추모관 정보 저장'));
                    viewModel.setPicture().then((_) => debugPrint('추모관 사진 저장'));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WillSelectInfoScreen(),
                      ),
                    );
                  },
                ),
              ));
        }));
  }
}
