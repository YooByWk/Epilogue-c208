# 이미지 캐러셀 만들기 (메인 배너에 사용)
```
carousel_slider: ^4.2.1
```

- Params
```
items: items,
options: CarouselOptions(
  // 슬라이더의 가로세로 비율
   aspectRatio: 16/9,
  // 화면에 보이는 슬라이드의 너비 비율(1은 전체너비)
   viewportFraction: 0.8,
  // 처음에 보여줄 슬라이더 인덱스
   initialPage: 0,
  // 무한 슬라이드 여부
   enableInfiniteScroll: true,
  // 슬라이드 넘어가는 기본 방향(왼→오)에서 반대인지
   reverse:false,
  // 몇 초 후 넘어가게 할지
   autoPlayInterval: Duration(seconds: 3)
  // 슬라이드 넘어갈 때 애니메이션 지속 시간
    autoPlayAnimationDuration: Duration(milliseconds: 800),
  // 애니메이션 속도 곡선
    autoPlayCurve: Curves.fastOutSlowIn,
  // 중앙에 위치한 슬라이드를 다른 슬라이드보다 크게 만들지
    enlargeCenterPage: true,
  // 중앙 페이지 확대 시 배율 (30% 더 크게)
    enlargeFactor: 0.3,
  // 페이지 변경 시 호출되는 콜백함수 (변경 페이지 index, 변경 reason 매개변수로 받을 수 있음)
    onPageChanged: callbackFunction,
  // 슬라이더 넘어가는 방향
    scrollDirection: Axis.horizontal, 
   )
```


- 전체 코드
```
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MainBannerWidget extends StatefulWidget {
  MainBannerWidget({super.key});

  @override
  _MainBannerWidgetState createState() => _MainBannerWidgetState();
}

class _MainBannerWidgetState extends State<MainBannerWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> imageList = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
    'assets/images/banner4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
	  // 이미지와 인디케이터를 중첩하기 위해 Stack 사용
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        CarouselSlider(
          carouselController: _controller,
          items: imageList.map((imagePath) {
            return Builder(
              builder: (context) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    fit: BoxFit.fill,
                    imagePath,
                  ),
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
            children: imageList.asMap().entries.map((entry) { 
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(
                        _current == entry.key ? 0.9 : 0.4),
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
```

- 변수 앞에 _(언더스코어)를 사용하는 이유?<br>
private으로 만들기 위함. 정의된 라이브러리 내부에서만 접근 가능(캡슐화)

- asMap()
리스트 각 항목에 대한 인덱스를 key로, 해당 항목을 value로 하는 Map 생성<br>
⇒ imageList 값을 {0: ‘image1’, 2: ‘image2’, …}와 같이 반환

- entries
map의 모든 엔트리(key-value 쌍)을 반복할 수 있는 반복자 반환

- .toList()를 사용하는 이유?
Dart에서 컬렉션을 리스트로 변환하기 위해서<br>
map 함수를 사용해 반환된 시퀀스는 Iterable 타입으로 실제 리스트가 아님.<br>
따라서 children 같은 속성에 시퀀스 직접 제공하려면 List로 변환해야 함.
