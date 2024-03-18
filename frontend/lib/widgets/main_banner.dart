import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/main.dart';

class BannerItem {
  final String imagePath;
  final String description;
  final String routeName;
  final String buttonText;

  BannerItem({
    required this.imagePath,
    required this.description,
    required this.routeName,
    required this.buttonText,
  });
}

class MainBannerWidget extends StatefulWidget {
  MainBannerWidget({super.key});

  @override
  _MainBannerWidgetState createState() => _MainBannerWidgetState();
}

class _MainBannerWidgetState extends State<MainBannerWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<BannerItem> banners = [
    BannerItem(
        imagePath: 'assets/images/banner1.jpg',
        description: '블록체인을 활용한 디지털 유언장 서비스\n\n당신의 유언장을 남겨보세요.',
        routeName: '/will',
        buttonText: '유언장 기록하기',
    ),
    BannerItem(
      imagePath: 'assets/images/banner2.jpg',
      description: '사랑하는 가족, 친구들에게 마음을 전하세요.',
      routeName: '/letter',
      buttonText: '편지 남기기',
    ),
    BannerItem(
      imagePath: 'assets/images/banner3.jpg',
      description: '문자, 메일로 전달 받은 코드를 통해\n유언장을 열람할 수 있습니다.',
      routeName: '',
      buttonText: '유언 열람하기',
    ),
    BannerItem(
      imagePath: 'assets/images/banner4.jpg',
      description: '사랑하는 사람들과의 아름다운 추억을 간직하세요.',
      routeName: '/memorial',
      buttonText: '디지털 추모관',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CarouselSlider(
          carouselController: _controller,
          items: banners.map((banner) {
            return Builder(
              builder: (context) {
                return Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Opacity(
                        opacity: 0.5,
                        child: Image.asset(
                          banner.imagePath,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 50,
                      right: 0,
                      left: 0,
                      child: Text(
                        banner.description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 50,
                        right: 0,
                        left: 0,
                        child: Center(
                            child: SizedBox(
                          width: 150,
                          child: CommonButtonWidget(
                            text: banner.buttonText,
                            backgroundColor: themeColour5,
                            onPressed: () {
                              Navigator.pushNamed(context, banner.routeName);
                            },
                          ),
                        ))),
                  ],
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 250,
            viewportFraction: 1.0,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 4),
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Positioned(
          bottom: 8.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: banners.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white
                        .withOpacity(_current == entry.key ? 0.9 : 0.4),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
