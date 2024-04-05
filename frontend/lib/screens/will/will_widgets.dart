import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/main/main_body_screen.dart';
import 'package:frontend/view_models/will_view_models/memorial_name_picture_viewmodel.dart';
import 'package:frontend/view_models/will_view_models/witness_viewmodel.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:provider/provider.dart';

class WillEpitaphWidget extends StatelessWidget {
  final MemorialNamePictureViewModel viewModel;


  WillEpitaphWidget({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
          return Container(
            margin: EdgeInsets.only(
              top: 10,
            ),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.11,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: themeColour4),
              boxShadow: [
                BoxShadow(
                  color: themeColour4.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: TextFormField(
              onChanged: (value) => viewModel.setGraveName(value),
              style: TextStyle(
                decorationThickness: 0,
                fontSize: 30,
                color: themeColour5,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: '묘비명 입력하기',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
  }
}

class TextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;

  const TextWidget({
    required this.text,
    required this.fontSize,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        color: Colors.black,
        fontFamily: 'Roboto Serif',
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}

////////////////////// 장례 외 추가 정보 선택 버튼 //////////////////////////
class ChoiceButtonWidget extends StatefulWidget {
  _ChoiceButtonWidgetState createState() => _ChoiceButtonWidgetState();

  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const ChoiceButtonWidget({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });
}

class _ChoiceButtonWidgetState extends State<ChoiceButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.15,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: widget.isSelected ? themeColour5 : Colors.black26,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.check_circle_outline,
                color: widget.isSelected ? themeColour5 : Colors.black26,
                size: 35,
              ),
              SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.text,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: widget.isSelected ? themeColour5 : Colors.black26,
                  fontFamily: 'Roboto Serif',
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//////////////// 유언 생성 중 선택 버튼 ///////////////////////////
class WillCommonButtonWidget extends StatelessWidget {
  final String text;
  final Color? fontColor;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? fontSize;
  final VoidCallback onPressed;

  const WillCommonButtonWidget({
    required this.text,
    this.backgroundColor = Colors.white,
    this.fontColor = Colors.black,
    required this.onPressed,
    this.width = 150.0,
    this.height = 35.0,
    this.fontSize = 30.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: themeColour3),
            boxShadow: [
              BoxShadow(
                color: themeColour4.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }
}

class TextButtonWidget extends StatelessWidget {
  final String? nextText;
  final String? preText;
  final Widget? nextPage;
  final Widget? prePage;
  final VoidCallback? onPressed;

  const TextButtonWidget({
    this.nextText,
    this.preText,
    this.nextPage,
    this.prePage,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Stack(children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (preText != null)
                TextButton(
                  onPressed: () {
                    prePage != null
                        ? Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => prePage!,
                            ),
                          )
                        : Navigator.pop(context);
                  },
                  child: Text(
                    preText!,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Roboto Serif',
                      color: themeColour5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              if (nextText != null)
                TextButton(
                  onPressed: onPressed ?? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => nextPage!,
                            ),
                          );
                        },
                  child: Text(
                    nextText!,
                    style: TextStyle(
                      fontSize: 30,
                      fontFamily: 'Roboto Serif',
                      color: themeColour5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ]),
    );
  }
}

//////////////////// 녹음 중 스탑워치 ////////////////////////////////
class StopwatchWidget extends StatefulWidget {
  @override
  _StopwatchWidgetState createState() => _StopwatchWidgetState();
}

class _StopwatchWidgetState extends State<StopwatchWidget> {
  Stopwatch _stopwatch = Stopwatch();
  String _elapsedTime = '00:00:00';

  void _startTimer() {
    _stopwatch.start();
    setState(() {
      _elapsedTime = _formatTime(_stopwatch.elapsedMilliseconds);
    });
  }


  void _stopTimer() {
    _stopwatch.reset();
    setState(() {
      _elapsedTime = '00:00:00';
    });
  }

  String _formatTime(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return '$minutesStr:$secondsStr';
  }

  @override
  void dispose() {
    _stopwatch.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _elapsedTime,
      style: TextStyle(fontSize: 20),
    );
  }
}

////////////////////////////증인 위젯//////////////////////
class WillWitnessWidget extends StatelessWidget {
  final WitnessViewModel viewModel;

  WillWitnessWidget({
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          margin: EdgeInsets.only(
            top: 10,
          ),
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.9,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: themeColour3.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 20),
                        Text(
                          '성함',
                          style: TextStyle(
                            fontSize: 20,
                            color: themeColour4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) =>
                                viewModel.setWitnessName(value),
                            style: TextStyle(
                              decorationThickness: 0,
                              fontSize: 20,
                              color: themeColour5,
                            ),
                            decoration: InputDecoration(
                              hintText: '이싸피',
                              hintStyle: TextStyle(
                                  color: themeColour4.withOpacity(0.8)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 20),
                        Text(
                          '번호',
                          style: TextStyle(
                            fontSize: 20,
                            color: themeColour4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: TextFormField(
                            onChanged: (value) =>
                                viewModel.setWitnessMobile(value),
                            style: TextStyle(
                              decorationThickness: 0,
                              fontSize: 20,
                              color: themeColour5,
                            ),
                            decoration: InputDecoration(
                              hintText: '01012345678',
                              hintStyle: TextStyle(
                                  color: themeColour4.withOpacity(0.8)),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        CommonButtonWidget(
                            text: '핸드폰 인증',
                            width: 100,
                            onPressed: () async {
                              await viewModel.mobileCertificationSend();
                            })
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 20),
                          Text(
                            '인증번호',
                            style: TextStyle(
                              fontSize: 20,
                              color: themeColour4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) =>
                                  viewModel.setCertificationNumber(value),
                              style: TextStyle(
                                decorationThickness: 0,
                                fontSize: 20,
                                color: themeColour5,
                              ),
                              decoration: InputDecoration(
                                hintText: '인증번호를 입력해주세요',
                                hintStyle: TextStyle(
                                    color: themeColour4.withOpacity(0.8)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                          CommonButtonWidget(
                              text: '확인',
                              width: 60,
                              onPressed: () async {
                                bool result = await viewModel.verifyCode();
                                debugPrint(result.toString());
                                if (result) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('인증에 성공했습니다.')));
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('인증번호를 확인해주세요.')));
                                }
                              }),
                        ]),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(width: 20),
                          Text(
                            '이메일',
                            style: TextStyle(
                              fontSize: 20,
                              color: themeColour4,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) =>
                                  viewModel.setWitnessEmail(value),
                              style: TextStyle(
                                decorationThickness: 0,
                                fontSize: 20,
                                color: themeColour5,
                              ),
                              decoration: InputDecoration(
                                hintText: 'ssafy@samsung.com',
                                hintStyle: TextStyle(
                                    color: themeColour4.withOpacity(0.8)),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ])))
    ]);
  }
}
