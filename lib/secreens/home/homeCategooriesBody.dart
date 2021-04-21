import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/categoories.dart';
import 'package:elgawda/secreens/CategoriesCourses/subCategoriesCourses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeCategooriesBody extends StatelessWidget {
  const HomeCategooriesBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        scrollDirection: Axis.horizontal,
        primary: false,
        childAspectRatio: .8,
        shrinkWrap: true,
        children: List.generate(
          categoriesList.length,
          (index) {
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SubCategoriesCourses(
                        categories: categoriesList[index],
                      ),
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
                          height: 100,
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
              ),
            );
          },
        ),
      ),
    );
  }
}
