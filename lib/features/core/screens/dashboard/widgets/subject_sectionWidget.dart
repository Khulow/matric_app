import 'package:flutter/material.dart';
import 'package:matric_app/features/core/model/subjects_model.dart';
import 'package:svg_flutter/svg.dart';


class SubjectSection extends StatefulWidget {
  SubjectSection({super.key});

  @override
  State<SubjectSection> createState() => _SubjectSectionState();
}

class _SubjectSectionState extends State<SubjectSection> {
  List<SubjectsModel> subjects = [];

  void _getCategories() {
    subjects = SubjectsModel.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    _getCategories();
    return SizedBox(
      height: 150,
      child: ListView.separated(
          itemCount: subjects.length,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 20, right: 20),
          separatorBuilder: (context, index) => const SizedBox(
                width: 25,
              ),
          itemBuilder: (context, index) {
            return Container(
              width: 100,
              decoration: BoxDecoration(
                  color: subjects[index].boxColor.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(16)),
              child: Column( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(subjects[index].iconPath),
                    ),
                  ),
                  Text(
                    subjects[index].name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: 12),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
