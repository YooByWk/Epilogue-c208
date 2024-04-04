import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/view_models/will_view_models/my_will_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:provider/provider.dart';

class WillAdditionalInfo extends StatefulWidget {

    final Map<String, dynamic> willData;

    const WillAdditionalInfo({
      required this.willData,
      Key? key}) : super(key: key);
      // print(willData);
      
  @override
  _WillAdditionalInfoState createState() => _WillAdditionalInfoState();
}

class _WillAdditionalInfoState extends State<WillAdditionalInfo> {
  late Future myWillDataFuture;

  final List<String> infoTitle = [
    '연명치료',
    '장례방식',
    '묘방식',
    '장기기증',
    '디지털 추모관',
  ];

  final List<String> infoData = [
    'sustainCare',
    'funeralType',
    'graveType',
    'organDonation',
    'useMemorial',
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myWillDataFuture =
        Provider.of<MyWillViewModel>(context, listen: false).normalfetchData();
    myWillDataFuture.then((_) {
      debugPrint(
          'willData: ${Provider.of<MyWillViewModel>(context, listen: false).willData}');
    });
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint('추가정보 위젯 실행중${debugPrint(myWillDataFuture.toString())}');
    return ChangeNotifierProvider(
      create: (context) => MyWillViewModel(),
      child: FutureBuilder(
        future: myWillDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // 데이터를 기다리는 동안 표시할 위젯
          } else {
            return Consumer<MyWillViewModel>(
              builder: (context, value, child) {
                return Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: themeColour3.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(top: 10),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              margin: EdgeInsets.only(top: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: infoTitle
                                    .map((item) => Padding(
                                          padding:
                                              EdgeInsets.only(bottom: 12.0),
                                          child: Row(
                                            children: [
                                              CommonText(
                                                text: item,
                                                textColor: themeColour5,
                                                isBold: true,
                                                fontSize: 20,
                                              ),
                                              SizedBox(width: 20),
                                              CommonText(
                                                text: widget.willData[infoData[
                                                        infoTitle
                                                            .indexOf(item)]] ??
                                                    '미입력',
                                                textColor: themeColour3,
                                                isBold: true,
                                                fontSize: 20,
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     debugPrint('추가정보 위젯 실행중');
//     return ChangeNotifierProvider(
//       create: (context) => MyWillViewModel(),
//     child : Consumer<MyWillViewModel>(
//       builder :(context, value, child) {
//         return Column(
//       children: [
//         CommonButtonWidget(text: 'text', onPressed: () => {
//           debugPrint(value.willData['graveType'].toString())
//         } ),
//         Container(
//           decoration: BoxDecoration(
//             color: themeColour3.withOpacity(0.3),
//             borderRadius: BorderRadius.circular(20),
//           ),
//           height: MediaQuery.of(context).size.height * 0.3,
//           width: MediaQuery.of(context).size.width * 0.8,
//           margin: EdgeInsets.only(top: 10),
//           alignment: Alignment.center,
//           child: Row(
//             children: [
//               Expanded(
//                 flex: 5,
//                 child: Container(
//                   margin: EdgeInsets.only(top: 20, left: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: infoTitle
//                         .map((item) => Padding(
//                               padding: EdgeInsets.only(bottom: 12.0),
//                               child: Row(
//                                 children: [
//                                   CommonText(
//                                     text: item,
//                                     textColor: themeColour5,
//                                     isBold: true,
//                                     fontSize: 20,
//                                   ),
//                                   SizedBox(width: 20),
//                                   CommonText(
//                                     text: value.willData[item] ?? '미입력',
//                                     textColor: themeColour3,
//                                     isBold: true,
//                                     fontSize: 20,
//                                   ),
//                                 ],
//                               ),
//                             ))
//                         .toList(),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//       },
//     )
//     );
//   }
// }
