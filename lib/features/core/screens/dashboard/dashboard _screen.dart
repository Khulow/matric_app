import 'package:flutter/material.dart';
import 'package:matric_app/constants/colors.dart';
import 'package:matric_app/constants/image_strings.dart';
import 'package:matric_app/constants/sizes.dart';
import 'package:matric_app/constants/text_strings.dart';

import 'package:matric_app/features/core/screens/dashboard/widgets/subjets_headerwidget.dart';
import 'package:matric_app/features/core/screens/dashboard/widgets/subjets_takeexam.dart';

import 'widgets/subject_sectionWidget.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key});

  @override
  Widget build(BuildContext context) {
    final txtTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu,
          color: Colors.black,
        ),
        title: Text(
          "Dashboard",
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20, top: 7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: tCardBgColor,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Image(image: AssetImage(tUserProfileImage)),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical, // Set scroll direction to horizontal
        child: Padding(
          padding: const EdgeInsets.all(tDashbardPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tDashboardTitle,
                style: txtTheme.bodyLarge,
              ),
              Text(
                tDashboardHeading,
                style: txtTheme.subtitle1,
              ),
              const SizedBox(height: tDashbardPadding),
              Container(
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(width: 4)),
                ),
                child: Row(
                  children: [
                    Text(
                      tDashboardSearch,
                      style: txtTheme.subtitle1?.apply(
                        color: Colors.grey.withOpacity(0.5),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: tDashbardPadding),
              SubjectSectionHeader(onPressed: () {  },),
              SubjectSection(),
              const SubjectSectionExam(),
              SubjectSection(),
            ],
          ),
        ),
      ),
    );
  }
}
