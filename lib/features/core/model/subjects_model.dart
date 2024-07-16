import 'package:flutter/material.dart';
import 'package:matric_app/miscellaneous/constants/colors.dart';

class SubjectsModel {
  String name;
  String iconPath;
  Color boxColor;

  SubjectsModel({
    required this.name,
    required this.iconPath,
    required this.boxColor,
  });
  static List<SubjectsModel> getCategories() {
    List<SubjectsModel> subjects = [];

    subjects.add(SubjectsModel(
        name: 'MATHEMATICS',
        iconPath: 'assets/subjects/Mathematics.svg',
        boxColor: tDashboardColor1));

    subjects.add(SubjectsModel(
        name: 'ACCOUNTING',
        iconPath: 'assets/subjects/Accounting.svg',
        boxColor: tDashboardColor3));

    subjects.add(SubjectsModel(
        name: 'AGRICULTURE STUDIES',
        iconPath: 'assets/subjects/Agriculture-studies.svg',
        boxColor: const Color(0xff92A3FD)));

    subjects.add(SubjectsModel(
        name: 'CONSUMER STUDIES',
        iconPath: 'assets/subjects/consumer-studies.svg',
        boxColor: const Color(0xffC58BF2)));

    subjects.add(SubjectsModel(
        name: 'DRAMATIC ARTS',
        iconPath: 'assets/subjects/Dramatic-Arts.svg',
        boxColor: const Color(0xff92A3FD)));

    subjects.add(SubjectsModel(
        name: 'ECONOMICS',
        iconPath: 'assets/subjects/Economics.svg',
        boxColor: const Color(0xffC58BF2)));

    subjects.add(SubjectsModel(
        name: 'GEOGRAPHY',
        iconPath: 'assets/subjects/Geography.svg',
        boxColor: const Color(0xff92A3FD)));

    subjects.add(SubjectsModel(
        name: 'HISTORY',
        iconPath: 'assets/subjects/History.svg',
        boxColor: const Color(0xffC58BF2)));

    subjects.add(SubjectsModel(
        name: 'INFORMATION TECHNOLOGY',
        iconPath: 'assets/subjects/IT.svg',
        boxColor: const Color(0xff92A3FD)));

    subjects.add(SubjectsModel(
        name: 'LIFE SCIENCES',
        iconPath: 'assets/subjects/Life-Sciences.svg',
        boxColor: const Color(0xffC58BF2)));

    subjects.add(SubjectsModel(
        name: 'LIFE ORIENTATION',
        iconPath: 'assets/subjects/LO.svg',
        boxColor: const Color(0xff92A3FD)));

    subjects.add(SubjectsModel(
        name: 'MATHEMATICS LITERACY',
        iconPath: 'assets/subjects/mathematical-literacy.svg',
        boxColor: const Color(0xffC58BF2)));

    subjects.add(SubjectsModel(
        name: 'MUSIC',
        iconPath: 'assets/subjects/Music.svg',
        boxColor: const Color(0xff92A3FD)));

    subjects.add(SubjectsModel(
        name: 'PHYSICAL SCIENCES',
        iconPath: 'assets/subjects/Physical-Science.svg',
        boxColor: const Color(0xffC58BF2)));

    subjects.add(SubjectsModel(
        name: 'VISUAL ARTS',
        iconPath: 'assets/subjects/Virtual-arts.svg',
        boxColor: const Color(0xff92A3FD)));

    subjects.add(SubjectsModel(
        name: 'BUSINESS STUDIES',
        iconPath: 'assets/subjects/business-studies.svg',
        boxColor: const Color(0xff92A3FD)));

    return subjects;
  }
}
