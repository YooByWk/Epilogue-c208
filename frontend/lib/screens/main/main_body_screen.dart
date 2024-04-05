import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/main_willicon_widget.dart';
import 'package:frontend/widgets/main_description.dart';
import 'package:frontend/widgets/main_banner.dart';


class MainBodyScreen extends StatelessWidget {
  final Function(int)? switchTab;
  const MainBodyScreen({super.key, this.switchTab});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo_small.png',
          height: 50,
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MainBannerWidget(switchTab: switchTab,),
              SizedBox(height: 30),
              MainDescriptionWidget(
                text: '당신의 삶을 \n오랫동안 기념할 수 있는 플랫폼',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: 30),
              MainDescriptionWidget(
                text: '에필로그는 법적 효력이 있는 유언의 5가지 형식 중\n녹음 방식을 통한 디지털 유언장 서비스를 제공합니다.\n\n저장된 유언장은 블록체인 기술을 통해\n타인에 의해 위변조, 훼손되지 않고 안전하게 보관됩니다.',
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainWilliconWidget(
                    text: '자필증서',
                    imagePath: 'assets/images/letter.png',
                  ),
                  MainWilliconWidget(
                    text: '녹음',
                    textColor: themeColour5,
                    borderColor: themeColour5,
                    imagePath: 'assets/images/voice.png',
                  ),
                  MainWilliconWidget(
                    text: '공정증서',
                    imagePath: 'assets/images/jury.png',
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MainWilliconWidget(
                    text: '비밀증서',
                    imagePath: 'assets/images/secret.png',
                  ),
                  MainWilliconWidget(
                    text: '구수증서',
                    imagePath: 'assets/images/emergency.png',
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        )
      ),
    );
  }
}
