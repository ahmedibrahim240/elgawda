import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/secreens/CategoriesCourses/allCategories.dart';
import 'package:elgawda/secreens/home/instractorlistvie.dart';
import 'package:elgawda/secreens/instuctor/allInstuctor.dart';
import 'package:flutter/material.dart';

import 'homeCategooriesBody.dart';
import 'homefunctions.dart';

class Home extends StatefulWidget {
  static final route = '/';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context: context),
      body: RefreshIndicator(
        onRefresh: () async {
          customOnRefresh(onRefresh: () {
            setState(() {
              loading = !loading;
            });
          }, affterRefresh: () {
            setState(() {
              loading = !loading;
            });
          });
        },
        child: (loading)
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView(
                shrinkWrap: true,
                primary: true,
                children: [
                  homePoster(context),
                  sectionTitle(
                    title: getTranslated(context, 'categories'),
                    context: context,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => AllCategories(),
                        ),
                      );
                    },
                  ),
                  HomeCategooriesBody(),
                  sectionTitle(
                      title: getTranslated(context, 'instructor'),
                      context: context,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => AllInstuctor(),
                          ),
                        );
                      }),
                  InstractorListView(),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: featuredSections(context: context),
                  ),
                ],
              ),
      ),
    );
  }
}
