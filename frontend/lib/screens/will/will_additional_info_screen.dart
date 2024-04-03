import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/main/main_screen.dart';
import 'package:frontend/screens/will/will_widgets.dart';
import 'package:frontend/view_models/will_view_models/additional_viewmodel.dart';
import 'package:provider/provider.dart';

class WillAdditionalInfoScreen extends StatefulWidget {
  const WillAdditionalInfoScreen({Key? key}) : super(key: key);

  @override
  _WillAdditionalInfoScreenState createState() =>
      _WillAdditionalInfoScreenState();
}

class _WillAdditionalInfoScreenState extends State<WillAdditionalInfoScreen> {
  String? sustainCareOption;
  String? organDonationOption;
  String? funeralOption;
  String? graveOption;

  @override
  void initState() {
    super.initState();
    sustainCareOption = null;
    organDonationOption = null;
    funeralOption = null;
    graveOption = null;
  }

  // 선택한 항목을 업데이트하는 함수
  void updateSustainCare(String option) {
    setState(() {
      if (sustainCareOption == option) {
        sustainCareOption = null; // 이미 선택된 항목을 다시 선택하면 선택 해제
      } else {
        sustainCareOption = option;
      }
    });
  }

  void updateOrganDonation(String option) {
    setState(() {
      if (organDonationOption == option) {
        organDonationOption = null;
      } else {
        organDonationOption = option;
      }
    });
  }

  void updateFuneral(String option) {
    setState(() {
      if (funeralOption == option) {
        funeralOption = null;
      } else {
        funeralOption = option;
      }
    });
  }

  void updateGrave(String option) {
    setState(() {
      if (graveOption == option) {
        graveOption = null;
      } else {
        graveOption = option;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AdditionalViewModel(),
        child:
            Consumer<AdditionalViewModel>(builder: (context, viewModel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeColour2,
              title: const Text('유언장 생성하기'),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(left: 30, top: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      text: "연명치료 여부",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceButtonWidget(
                          text: "희망",
                          isSelected: sustainCareOption == "희망",
                          onTap: () => updateSustainCare('희망'),
                        ),
                        ChoiceButtonWidget(
                          text: "미희망",
                          isSelected: sustainCareOption == "미희망",
                          onTap: () => updateSustainCare('미희망'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextWidget(
                      text: "장기기증 여부",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceButtonWidget(
                          text: "희망",
                          isSelected: organDonationOption == "희망",
                          onTap: () => updateOrganDonation("희망"),
                        ),
                        ChoiceButtonWidget(
                          text: "미희망",
                          isSelected: organDonationOption == "미희망",
                          onTap: () => updateOrganDonation("미희망"),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextWidget(
                      text: "장례방식",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceButtonWidget(
                          text: "매장",
                          isSelected: funeralOption == "매장",
                          onTap: () => updateFuneral('매장'),
                        ),
                        ChoiceButtonWidget(
                          text: "화장",
                          isSelected: funeralOption == "화장",
                          onTap: () => updateFuneral('화장'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceButtonWidget(
                          text: "시신기증",
                          isSelected: funeralOption == "시신기증",
                          onTap: () => updateFuneral('시신기증'),
                        ),
                        ChoiceButtonWidget(
                          text: "기타",
                          isSelected: funeralOption == "기타",
                          onTap: () => updateFuneral('기타'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextWidget(
                      text: "묘 방식",
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceButtonWidget(
                          text: "매장",
                          isSelected: graveOption == "매장",
                          onTap: () => updateGrave('매장'),
                        ),
                        ChoiceButtonWidget(
                          text: "납골당",
                          isSelected: graveOption == "납골당",
                          onTap: () => updateGrave('납골당'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceButtonWidget(
                          text: "봉안묘",
                          isSelected: graveOption == "봉안묘",
                          onTap: () => updateGrave('봉안묘'),
                        ),
                        ChoiceButtonWidget(
                          text: "평장묘",
                          isSelected: graveOption == "평장묘",
                          onTap: () => updateGrave('평장묘'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChoiceButtonWidget(
                          text: "수목장",
                          isSelected: graveOption == "수목장",
                          onTap: () => updateGrave('수목장'),
                        ),
                        ChoiceButtonWidget(
                          text: "산분",
                          isSelected: graveOption == "산분",
                          onTap: () => updateGrave('산분'),
                        ),
                      ],
                    ),
                    ChoiceButtonWidget(
                      text: "기타",
                      isSelected: graveOption == "기타",
                      onTap: () => updateGrave('기타'),
                    ),
                    SizedBox(height: 40,),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              color: themeColour3,
              height: 80,
              child: InkWell(
                onTap: () {
                  viewModel.setSustainCare(sustainCareOption!);
                  viewModel.setGraveType(graveOption!);
                  viewModel.setFuneralType(funeralOption!);
                  viewModel.setOrganDonation(organDonationOption!);
                  viewModel.setAdditional().then((_) {
                    if (viewModel.errorMessage == null) {
                      Navigator.pushNamed(context, '/home');
                    } else {
                      if (viewModel.errorMessage != null) {
                        Navigator.pushNamed(context, '/home');
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text(viewModel.errorMessage!),
                        //   ),
                        // );
                      }
                    }
                  });
                },
                child: Center(
                  child: Text(
                    "항목 선택 완료",
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
