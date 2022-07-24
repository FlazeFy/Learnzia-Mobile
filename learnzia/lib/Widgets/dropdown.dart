


import 'package:flutter/material.dart';
import 'package:learnzia/Firebase/Classroom/EditClass.dart';
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

//For classroom
class DropDownType extends StatefulWidget {
  const DropDownType({Key key}) : super(key: key);

  @override
  State<DropDownType> createState() => _DropDownTypeState();
}

class _DropDownTypeState extends State<DropDownType> {
  String dropdownValue = 'Public';

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
          typeClassCtrl = dropdownValue;
        });
      },
      items: <String>['Public', 'Private']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class DropDownCategory2 extends StatefulWidget {
  const DropDownCategory2({Key key}) : super(key: key);

  @override
  State<DropDownCategory2> createState() => _DropDownCategoryState2();
}

class _DropDownCategoryState2 extends State<DropDownCategory2> {
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
          categoryClassCtrl = dropdownValue;
        });
      },
      items: <String>['Math', 'Coding', 'Science', 'Design', 'History', 'Engineering', 'Multi']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}