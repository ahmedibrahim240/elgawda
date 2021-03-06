import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/InstructorApi.dart';
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
    return FutureBuilder(
      future: InstructorApi.fetchInstructor(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return (snapshot.data == null || snapshot.data.isEmpty)
              ? Container()
              : ListView.builder(
                  itemCount:
                      (snapshot.data.length <= 4) ? snapshot.data.length : 4,
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        insructorCard(
                            index: index,
                            instructor: snapshot.data[index],
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => InstructorPageView(
                                    instructor: snapshot.data[index],
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
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  insructorCard({int index, Function onTap, InstructorModels instructor}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: customCachedNetworkImage(
                context: context,
                boxFit: BoxFit.cover,
                url: instructor.image_path,
              ),
            ),
          ),
          SizedBox(width: 20),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                height: 20,
                child: Text(
                  (instructor.name) ?? '',
                  style: AppTheme.headingColorBlue.copyWith(fontSize: 10),
                ),
              ),
              (instructor.bio == null || instructor.bio == '')
                  ? Container()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width - 200,
                      height: 50,
                      child: Text(
                        (instructor.bio) ?? '',
                        style: AppTheme.subHeadingColorBlue,
                      ),
                    ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 200,
                height: 50,
                child: Text(
                  (instructor.job) ?? '',
                  style: AppTheme.subHeadingColorBlue,
                ),
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
