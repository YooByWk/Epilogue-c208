import 'package:flutter/material.dart';

// 메모리얼 프로필 이미지
class MemorialProfileImage extends StatelessWidget {
  final String imagePath;

  MemorialProfileImage({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    debugPrint('imagePath : $imagePath');
    return CircleAvatar(
      radius: 50.0,
      backgroundImage: NetworkImage(imagePath),
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

