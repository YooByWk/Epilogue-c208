//memorial_letter_upload.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_detail_letterTab_viewmodel.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:provider/provider.dart';

// class MemorialLetterUpload extends StatefulWidget {
//   _MemorialLetterUploadState createState() => _MemorialLetterUploadState();
// }

class MemorialLetterUpload extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LetterTabViewModel(),
        child:
        Consumer<LetterTabViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeColour2,
              title: const Text('추모관 편지 남기기'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 30),
                  Center(
                      child: CommonText(
                        text: '고인에게 생전에 하지 못 했던 말을 남겨보세요.',
                        fontSize: 20,
                      )),
                  SizedBox(height: 30),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            viewModel.setNickname(value);
                          },
                          decoration: InputDecoration(
                            hintText: '보내는 사람 (6자 이내)',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(2.0),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0)),
                                focusedBorder: OutlineInputBorder(
                                  // 포커스됐을 때 외곽선 설정
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(2.0)),
                              borderSide: BorderSide(
                                  color: themeColour5, width: 2.0), // 여기서 색깔 변경
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextField(
                          onChanged: (value) {
                            viewModel.setContent(value);
                          },
                          maxLines: null,
                          minLines: 5,
                          decoration: InputDecoration(
                            hintText: '편지 내용을 작성해주세요. (30자 이내)',
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 20.0),
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(2.0),
                                ),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2.0)),
                                focusedBorder: OutlineInputBorder(
                                  // 포커스됐을 때 외곽선 설정
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(2.0)),
                                  borderSide: BorderSide(
                                      color: themeColour5, width: 2.0), // 여기서 색깔 변경
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              color: themeColour3,
              height: 80,
              child: InkWell(
                onTap: () {
                  viewModel.uploadLetter().then((_) {
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