import 'package:flutter/material.dart';
import 'package:frontend/widgets/common_button.dart';
import 'package:frontend/widgets/common_text_widget.dart';
import 'package:frontend/main.dart';
// 메모리얼 프로필 이미지
class MemorialProfileImage extends StatelessWidget {
  final String? imagePath;

  MemorialProfileImage({this.imagePath});

  @override
  Widget build(BuildContext context) {
    // debugPrint('imagePath : $imagePath');
    return CircleAvatar(
      radius: 50.0,
      backgroundImage: NetworkImage(imagePath!),
    );
  
  }
}

// common widget으로 분리 예정
class QuickMenu  extends StatelessWidget {
  final List<String> items;
  final Function(String) onSelected;

  const QuickMenu ({
    super.key,
    required this.items,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: onSelected,
      itemBuilder: (BuildContext context) {
        return items.map((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList();
      },
    );
  }
}

class MemorialVideoUploadButton extends StatelessWidget {
  final Function() onPressed;
  late double width;

  MemorialVideoUploadButton({required this.onPressed, required this.width}); 

  @override
  Widget build(BuildContext context) {
    return 
    Material(
      color: Colors.transparent,
      child:
    InkWell(onTap: onPressed,splashColor: themeColour5, child: 
    Ink(
      height: 40,
      decoration: BoxDecoration(
        color : themeColour1,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child : 
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children:
    [
      Icon( Icons.add, size: 20.0, color: Colors.black),
      CommonText(text: '동영상 추가', textColor: Colors.black, fontSize: 16.0, )
    ],
    )
    ))
  );}
}