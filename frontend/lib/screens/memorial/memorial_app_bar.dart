import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:frontend/screens/memorial/memorial_detail/memorial_detail_widgets.dart';

class MemorialAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String screenName;
  final String colour;
  final bool isMenu;
  final List<String>? items;
  final Function? onSelected;
final String? value;

  MemorialAppBar(
    {required this.screenName,
    this.colour = 'themeColour2',
    this.isMenu = false,
    this.items,
    this.onSelected,
      this.value,
    }
    );

  Color getColour(String colour) {
    switch (colour) {
      case 'themeColour1':
        return themeColour1;
      case 'themeColour2':
        return themeColour2;
      case 'themeColour3':
        return themeColour3;
      case 'themeColour4':
        return themeColour4;
      case 'themeColour5':
        return themeColour5;
      default:
        return themeColour2;
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(screenName),
      centerTitle: true,
      backgroundColor: getColour(colour),
      actions: <Widget>[
        if (isMenu && items != null && onSelected != null)
          QuickMenu(
            items: items!,
            onSelected: clickHandler(value),
          ),
      ],
    );
  }

   clickHandler (v) {
    debugPrint('sdfsdf${v}');
  }
}