import 'package:flutter/material.dart';
import 'package:frontend/view_models/memorial_view_models/memorial_list_viewmodel.dart';

class MemorialText extends StatelessWidget {
  final String text;
  final double size;
  final bool isBold;
  final String align;

  MemorialText(
      {required this.text,
      required this.size,
      Key? key,
      this.isBold = false,
      this.align = 'center'})
      : super(key: key);

  TextAlign getTextAlign(String align) {
    switch (align) {
      case 'left':
        return TextAlign.left;
      case 'right':
        return TextAlign.right;
      case 'center':
        return TextAlign.center;
      case 'justify':
        return TextAlign.justify;
      case 'start':
        return TextAlign.start;
      case 'end':
        return TextAlign.end;
      default:
        return TextAlign.center;
    }
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;

    return Container(
        width: deviceWidth,
        child: Text(
          text,
          softWrap: true,
          textAlign: getTextAlign(align),
          style: TextStyle(
            color: Colors.white,
            fontSize: size,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ));
  }
}

class MemorialImage extends StatelessWidget {
  const MemorialImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/memorial.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}



// StatefulWidget으로 변환된 MemorialSearchWidget
class MemorialSearchWidget extends StatefulWidget {
  final MemorialListViewModel viewModel;

  const MemorialSearchWidget({Key? key, required this.viewModel}) : super(key: key);

  @override
  _MemorialSearchWidgetState createState() => _MemorialSearchWidgetState();
}

class _MemorialSearchWidgetState extends State<MemorialSearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch() {
    // 검색어를 viewModel에 설정
    widget.viewModel.setSearchWord(_searchController.text);
    // 검색 실행 후 결과 return
    widget.viewModel.search();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextField(
          controller: _searchController, // TextEditingController를 사용하여 입력값 관리
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(Icons.search),
              onPressed: _handleSearch, // 검색 아이콘 버튼 클릭시 _handleSearch 호출
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            hintText: '고인의 성함, 묘비명으로 검색',
            hintStyle: TextStyle(color: Colors.grey[800]),
          ),
        ),
      ),
    );
  }
}
