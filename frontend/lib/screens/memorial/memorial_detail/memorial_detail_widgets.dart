import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class MemorialDetailImage extends StatelessWidget {
  final String imagePath;
 
  MemorialDetailImage({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(imagePath);
  }
}

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