


import 'package:flutter/material.dart';
import 'package:learnzia/SecondaryMenu/TabController/createPost.dart';

class DropDownCategory extends StatefulWidget {
  const DropDownCategory({Key key}) : super(key: key);

  @override
  State<DropDownCategory> createState() => _DropDownCategoryState();
}

class _DropDownCategoryState extends State<DropDownCategory> {
  String dropdownValue = 'Math';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      iconSize: 24,
      style: const TextStyle(color: Color(0xFFF1C40F)),
      underline: Container(
        height: 2,
        color: const Color(0xFFF1C40F),
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
          categoryCtrl = dropdownValue;
        });
      },
      items: <String>['Math', 'Coding', 'Science', 'Design', 'History', 'Engineering']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
