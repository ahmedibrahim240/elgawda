import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/categoories.dart';
import 'package:elgawda/secreens/CategoriesCourses/categoriesCoursesPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SubCategoriesCourses extends StatefulWidget {
  final Categories categories;

  const SubCategoriesCourses({Key key, this.categories}) : super(key: key);
  @override
  _SubCategoriesCoursesState createState() => _SubCategoriesCoursesState();
}

class _SubCategoriesCoursesState extends State<SubCategoriesCourses> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        primary: false,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        itemCount: categoriesList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CategoriesCoursesPage(),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: customCachedNetworkImage(
                        context: context,
                        url: categoriesList[index].image,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 30,
                      width: (MediaQuery.of(context).size.width) * .5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Colors.black.withOpacity(.4),
                      ),
                      child: Center(
                        child: Text(
                          categoriesList[index].name,
                          style: AppTheme.heading.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) =>
            new StaggeredTile.count(2, index.isEven ? 1.5 : 2.5),
      ),
    );
  }
}
