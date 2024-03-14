import 'package:flutter/material.dart';
import 'package:frontend/main.dart';

class ScrollToTopBtn extends StatefulWidget {
  final ScrollController scrollController;
  ScrollToTopBtn({required this.scrollController});

  @override
  _ScrollToTopBtnState createState() => _ScrollToTopBtnState();
}


class _ScrollToTopBtnState extends State<ScrollToTopBtn> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(() {
      if (widget.scrollController.position.pixels >= 1000 && !_isVisible) {
        setState(() {
          _isVisible = true;
        });
      } else if (widget.scrollController.position.pixels < 1000 && _isVisible) {
        setState(() {
          _isVisible = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible
        ? FloatingActionButton(
            child: Icon(Icons.arrow_upward),
            onPressed: () {
              widget.scrollController.animateTo(
                0.0,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            },
            backgroundColor: themeColour4.withOpacity(0.5),
            mini : true,
          )
        : Container();
  }
}