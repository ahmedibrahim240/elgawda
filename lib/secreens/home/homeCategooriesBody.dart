import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/HomeDataApi.dart';
import 'package:elgawda/secreens/CategoriesCourses/categorespage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeCategooriesBody extends StatelessWidget {
  const HomeCategooriesBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: HomeDaTaApi.fetchHomeCategories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data);
          return (snapshot.data == null || snapshot.data.isEmpty)
              ? Container()
              : Container(
                  height: 100,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: categoresGridView(snapshot, context),
                );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  categoresGridView(AsyncSnapshot snapshot, BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      crossAxisSpacing: 5,
      mainAxisSpacing: 5,
      scrollDirection: Axis.horizontal,
      primary: false,
      childAspectRatio: .8,
      shrinkWrap: true,
      children: List.generate(
        snapshot.data.length,
        (index) {
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => Categorespage(
                      categores: snapshot.data[index].subcategories,
                      id: snapshot.data[index].id,
                      name: snapshot.data[index].name,
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
                          boxFit: BoxFit.cover,
                          context: context,
                          url: snapshot.data[index].image,
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
                            snapshot.data[index].name,
                            textAlign: TextAlign.center,
                            style: AppTheme.heading.copyWith(
                              color: Colors.white,
                              fontSize: 12,
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
    );
  }
}
