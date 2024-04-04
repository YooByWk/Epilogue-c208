import 'package:flutter/material.dart';

class MemorialCard extends StatelessWidget {
  final String imagePath;

  MemorialCard({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Image.asset(imagePath),
    );
  }
}