import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/instructor.dart';
import 'package:elgawda/secreens/instuctor/instructorPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InstractorListView extends StatefulWidget {
  @override
  _InstractorListViewState createState() => _InstractorListViewState();
}

class _InstractorListViewState extends State<InstractorListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: instructorList.length,
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      itemBuilder: (context, index) {
        return Column(
          children: [
            insructorCard(
                index: index,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => InstructorPageView(
                        instructor: instructorList[index],
                      ),
                    ),
                  );
                }),
            Divider(
              color: customColor.withOpacity(.5),
              thickness: 2,
            ),
          ],
        );
      },
    );
  }

  insructorCard({int index, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(instructorList[index].image),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                instructorList[index].insName,
                style: AppTheme.headingColorBlue,
              ),
              Text(
                instructorList[index].insWork,
                style: AppTheme.subHeadingColorBlue,
              ),
              Text(
                instructorList[index].insDevoplTitlle,
                style: AppTheme.subHeadingColorBlue,
              ),
            ],
          ),
          Expanded(
            child: Transform.rotate(
              angle: 180 * 3.14 / 180,
              child: Icon(
                Icons.arrow_back_ios,
                color: customColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
