import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/models/categoories.dart';
import 'package:elgawda/secreens/CategoriesCourses/categoriesCoursesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeCategooriesBody extends StatelessWidget {
  const HomeCategooriesBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customRaiseButtom(
                    text: categoriesList[index].name,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CategoriesCoursesPage(
                            categories: categoriesList[index],
                          ),
                        ),
                      );
                    },
                  ),
                  customRaiseButtom(
                    text: categoriesList[index * 2].name,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CategoriesCoursesPage(
                            categories: categoriesList[index],
                          ),
                        ),
                      );
                    },
                  ),
                  customRaiseButtom(
                    text: categoriesList[index].name,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CategoriesCoursesPage(
                            categories: categoriesList[index],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
