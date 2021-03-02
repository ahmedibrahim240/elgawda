import 'package:elgawda/secreens/home/instractorlistvie.dart';
import 'package:elgawda/secreens/instuctor/instuctor.dart';
import 'package:flutter/material.dart';

import 'homeCategooriesBody.dart';
import 'homefunctions.dart';

class Home extends StatefulWidget {
  static final route = '/';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        children: [
          homePoster(context),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: featuredSections(),
          ),
          sectionTitle(title: 'Categories', onTap: () {}),
          HomeCategooriesBody(),
          sectionTitle(
              title: 'Instructor',
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AllInstuctor(),
                  ),
                );
              }),
          InstractorListView(),
        ],
      ),
    );
  }
}
