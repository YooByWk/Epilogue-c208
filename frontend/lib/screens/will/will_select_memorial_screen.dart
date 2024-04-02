import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/will/will_epitaph_picture_screen.dart';
import 'package:frontend/screens/will/will_select_info_screen.dart';
import 'package:frontend/screens/will/will_viewer_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/view_models/will_view_models/memorial_use_viewmodel.dart';
import 'package:provider/provider.dart';

class WillSelectMemorialScreen extends StatefulWidget {
  _WillSelectMemorialScreenState createState() =>
      _WillSelectMemorialScreenState();
}

class _WillSelectMemorialScreenState extends State<WillSelectMemorialScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MemorialUseViewModel(),
        child: Consumer<MemorialUseViewModel>(
            builder: (context, viewModel, child) {
          return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    TextWidget(
                                      text: '디지털 추모관',
                                      fontSize: 50,
                                      fontWeight: FontWeight.w900,
                                    ),
                                    TextWidget(
                                      text: '을',
                                      fontSize: 50,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                                TextWidget(
                                  text: '이용하시나요?',
                                  fontSize: 50,
                                  fontWeight: FontWeight.w500,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextWidget(
                                  text:
                                      '디지털 추모관은 추후 유언이 공개되었을 때 \n회원님을 추억할 수 있는 공간입니다.',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                          ]),
                    ),
                    Center(
                      child: WillCommonButtonWidget(
                        text: "이용",
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.11,
                        onPressed: () {
                          viewModel.setUseMemorial('이용');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WillEpitaphPictureScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                    Center(
                      child: WillCommonButtonWidget(
                        text: "이용하지 않음",
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.11,
                        onPressed: () {
                          viewModel.setUseMemorial('이용하지 않음');
                          viewModel.setMemorial().then((_) {
                            debugPrint('추모관 저장');
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WillSelectInfoScreen(),
                            ),
                          );
                        },
                      ),
                    ),
                  ]),
              );
        }));
  }
}
