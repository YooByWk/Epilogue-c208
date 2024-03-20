import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/common_text_widget.dart';

class WillAdditionalInfo extends StatelessWidget {
  WillAdditionalInfo({super.key});

  final List<String> infoTitle = [
    '연명치료',
    '장례방식',
    '묘방식',
    '장기기증',
    '디지털 추모관',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: themeColour3.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          height: MediaQuery.of(context).size.height * 0.3,
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
                              padding: EdgeInsets.only(bottom: 12.0),
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
                                    text: 'userInfo',
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
  }
}
