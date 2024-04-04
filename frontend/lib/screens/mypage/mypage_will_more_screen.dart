import 'package:flutter/material.dart';
import 'package:frontend/screens/block_chain_test.dart';
import 'package:frontend/screens/mypage/mypage_play.dart';
import 'package:frontend/view_models/auth_view_models/user_viewmodel.dart';
import 'package:frontend/view_models/block_chain/block_chain_will_viewmodel.dart';
import 'package:frontend/view_models/will_view_models/my_will_viewmodel.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/popup_widget.dart';
import 'package:frontend/widgets/will_additional_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class MypageWillMoreScreen extends StatefulWidget {
  final String path;
  const MypageWillMoreScreen({
    required this.path,
    Key? key}) : super(key: key);

  @override
  _MypageWillMoreScreenState createState() => _MypageWillMoreScreenState();
}

class _MypageWillMoreScreenState extends State<MypageWillMoreScreen> {
  late Future myWillDataFuture;

  // late String audioPath;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myWillDataFuture = MyWillViewModel().normalfetchData();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('추가정보 위젯 테스트 : ${widget.path}');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserViewModel()),
        ChangeNotifierProvider(create: (context) => MyWillViewModel()),
      ],
      child: Consumer2<UserViewModel, MyWillViewModel>(
        builder: (context, userViewModel, myWillViewModel, child) {
          return FutureBuilder(
            future: myWillDataFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
                
              } else {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Scaffold(
                    appBar: AppBar(
                      title: CommonText(
                        text: '내가 기록한 유언',
                        fontSize: 30,
                        isBold: true,
                      ),
                      actions: [
                        Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: CommonButtonWidget(
                            text: '삭제',
                            width: 80,
                            fontSize: 20,
                            onPressed: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return PopupWidget(
                                    text:
                                        '삭제하면 처음부터 다시 생성해야 합니다.\n정말 삭제하시겠습니까?',
                                    buttonText1: '삭제',
                                    onConfirm1: () {},
                                    buttonText2: '취소',
                                    onConfirm2: () {},
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    body: Center(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CommonButtonWidget(
                                  height: 300,
                                  width: 300,
                                  text: '${myWillViewModel.graveName}',
                                  fontSize: 24,
                                  textColor: Colors.black,
                                  imagePath: 'assets/images/stone.png',
                                  onPressed: () {},
                                ),
                                Positioned(
                                    top: 40,
                                    child: Text('RIP', style: TextStyle(fontSize: 30),)),
                                Positioned(
                                  bottom: 50,
                                  child: Row(
                                    children: [
                                      myWillViewModel.graveImageAddress != null
                                          ? ClipOval(
                                        child: Image.network(
                                          myWillViewModel.graveImageAddress!,
                                          width: 60, // 이미지 크기, 필요에 따라 조정
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                          : Container(),
                                      SizedBox(width: 10,),
                                      Text('故${userViewModel.user!.name}', style: TextStyle(fontSize: 24),)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            MyPagePlay(path: widget.path),
                            // MyPagePlay(path: 'myWillViewModel.willData[]'),
                            WillAdditionalInfo(willData : myWillViewModel.willData),
                            SizedBox(height: 20),
                            CommonButtonWidget(
                              width: 250,
                              text: '저장된 유언 진위여부 확인',
                              onPressed: () async {
                                await BlockChainWillViewModel()
                                    .WillCheck()
                                    .then((res) {
                                  debugPrint(res.toString());
                                  if (res == '200') {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return PopupWidget(
                                          text: '유언이 안전하게 저장되고 있습니다.',
                                          buttonText1: '확인',
                                          onConfirm1: () {
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  } else {
                                    myWillViewModel.fixS3();
                                    showDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      builder: (BuildContext context) {
                                        return PopupWidget(
                                          text:
                                              '유언 변조가 감지되어\n 원본으로 복구했습니다.',
                                          buttonText1: '확인',
                                          onConfirm1: () {
                                            myWillViewModel.fixS3();
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                    );
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }
            },
          );
        },
      ),
    );
  }
}






//   @override
//   Widget build(BuildContext context) {
//     // final userViewModel = Provider.of<UserViewModel>(context, listen: false);
// // UserViewModel()
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => UserViewModel()),
//         ChangeNotifierProvider(create:  (context) => MyWillViewModel()),],
//       child: 
      
//       Consumer2 <UserViewModel, MyWillViewModel> (
//         builder :(context, userViewModel, myWillViewModel,  child) {
//           // debugPrint(userViewModel.user!.name);
//           return Scaffold(
//           appBar: AppBar(
//             title: CommonText(
//               text: '내가 기록한 유언',
//               fontSize: 30,
//               isBold: true,
//             ),
//             actions: [
//               Padding(
//                 padding: EdgeInsets.only(right: 20.0),
//                 child: CommonButtonWidget(
//                   text: '삭제',
//                   width: 80,
//                   fontSize: 20,
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       barrierDismissible: true,
//                       builder: (BuildContext context) {
//                         return PopupWidget(
//                             text: '삭제하면 처음부터 다시 생성해야 합니다.\n정말 삭제하시겠습니까?',
//                             buttonText1: '삭제',
//                             onConfirm1: (){},
//                             buttonText2: '취소',
//                             onConfirm2: (){},
//                           );
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//           body: Center(
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Stack(
//                     alignment: Alignment.center,
//                     children: [
//                       CommonButtonWidget(
//                         height: 300,
//                         width: 300,
//                         text: '묘비명\n故${userViewModel.user!.name}',
//                         fontSize: 24,
//                         textColor: Colors.black,
//                         imagePath: 'assets/images/stone.png',
//                         onPressed: () {},
//                       ),
//                       Positioned(
//                         top: 25,
//                         child: IconButton(
//                           iconSize: 30,
//                           icon: Icon(Icons.edit),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ],
//                   ),
//                   WillAdditionalInfo(),
//                   SizedBox(height: 20),
//                   CommonButtonWidget(width: 250,text: '저장된 유언 진위여부 확인', onPressed: () async =>{
//                     await BlockChainWillViewModel().WillCheck().then((res) {
//                       debugPrint(res.toString());
//                       if (res == '200') {
//                         showDialog(context: context, 
//                         builder: (BuildContext context) {
                          
//                           return PopupWidget(
//                             text: '유언이 안전하게 저장되고 있습니다.',
//                             buttonText1: '확인',
//                                                       onConfirm1: (){Navigator.pop(context);},
        
//                           );
//                         });
//                       } else {
//                         showDialog(
//                           context: context,
//                           barrierDismissible: true,
//                           builder: (BuildContext context) {
//                             return PopupWidget(
//                               text: '유언이 변경되었습니다.\n다시 생성해주세요.',
//                               buttonText1: '확인',
//                               onConfirm1: (){Navigator.pop(context);},
//                             );
//                           },
//                         );
//                       }
//                     }),
//                   })
//                 ],
//               ),
//             ),
//           ),
//         );
//         },
        
//       ),
//     );
//   }
// }
