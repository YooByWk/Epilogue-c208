import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_app_bar.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_phototab_viewmodel.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:provider/provider.dart';

class MemorialPhotoUpload extends StatefulWidget {
  _MemorialPhotoUploadState createState() => _MemorialPhotoUploadState();
}

class _MemorialPhotoUploadState extends State<MemorialPhotoUpload> {
  File? photo;

  Future<void> _pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg', 'gif'],
    );

    if (result != null) {
      debugPrint('사진 선택 완료');
      setState(() {
        photo = File(result.files.single.path!);
      });
    } else {
      debugPrint('사진 선택 취소');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => PhotoTabViewModel(),
        child:
            Consumer<PhotoTabViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeColour2,
              title: Text('추모관 사진 업로드'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 30),
                  Center(
                      child: CommonText(
                    text: '고인과의 추억이 담긴 사진을 공유해보세요.',
                    fontSize: 20,
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: InkWell(
                        onTap: () {
                          _pickFile(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.35,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                              border: Border.all(color: themeColour3),
                              boxShadow: [
                                BoxShadow(
                                  color: themeColour4.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              image: (photo != null)
                                  ? DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(File(photo!.path)))
                                  : null),
                          child: (photo != null)
                              ? null
                              : Center(
                                  child: Text(
                                    "사진 추가하기",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 90.0, vertical: 8.0),
                    child: CommonText(
                      text: "크기 제한 (사진 7Mb 이내)",
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextField(
                      onChanged: (value) {
                        viewModel.setContent(value);
                      },
                      maxLines: null,
                      minLines: 5,
                      decoration: InputDecoration(
                        hintText: '사진에 대한 설명을 남겨주세요.',
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 20.0),
                        border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(1.0),
                            ),
                            borderSide:
                                BorderSide(color: Colors.grey, width: 2.0)),
                        focusedBorder: OutlineInputBorder(
                          // 포커스됐을 때 외곽선 설정
                          borderRadius:
                              const BorderRadius.all(Radius.circular(1.0)),
                          borderSide: BorderSide(
                              color: themeColour5, width: 2.0), // 여기서 색깔 변경
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              color: themeColour3,
              height: 80,
              child: InkWell(
                onTap: () {
                  viewModel.setFile(photo!);
                  viewModel.setPhoto().then((_) {
                    if (viewModel.errorMessage == null) {
                      Navigator.pop(context, true);
                    } else {
                      if (viewModel.errorMessage != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(viewModel.errorMessage!),
                          ),
                        );
                      }
                    }
                  });
                },
                child: Center(
                  child: Text(
                    "업로드 하기",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 33,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
