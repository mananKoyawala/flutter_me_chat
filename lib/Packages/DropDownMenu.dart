import 'package:flutter/material.dart';
import 'package:me_chat/Packages/Package_Export.dart';

class DropDownMenu extends StatelessWidget {
  final List<String> items;
  final Function(String) onSelected;
  final Color? color;
  final Color? textColor;

  const DropDownMenu(
      {super.key,
      required this.items,
      required this.onSelected,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(color: color ?? Colors.green),
      ),
      child: PopupMenuButton<String>(
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return items.map((String item) {
            return PopupMenuItem<String>(
              value: item,
              child: Text(
                item,
                style: TextStyle(
                    color: textColor ?? white, fontWeight: FontWeight.w400),
              ),
            );
          }).toList();
        },
      ),
    );
  }
}


//* implementation (direct implement no iconButton nedded)

//TODO 1: Create a list
/*
  String dropLang = 'English';
  var languages = ['English', 'Gujarati', 'Hindi'];
*/

//TODO 2: Create the widget
/* 
   DropDownMenu(
      onSelected: (String value) {
        if (value == 'English') {
          languageController.changeLocale1('en');
        }
        if (value == 'Gujarati') {
           languageController.changeLocale1('gu');
        }
        if (value == 'Hindi') {
          languageController.changeLocale1('hi');
        }
      },
     items: languages,
    ),
*/