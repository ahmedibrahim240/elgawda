import 'package:elgawda/constants/constans.dart';
import 'package:flutter/material.dart';
import 'components/NotificationsContant.dart';

class Notificatios extends StatefulWidget {
  @override
  _NotificatiosState createState() => _NotificatiosState();
}

class _NotificatiosState extends State<Notificatios> {
  String title = 'Remind For Serial ';
  String date = '20 mim ';
  String contant =
      'Remind For Serial Remind For Serial Remind For Serial Remind For  ';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: ListView(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        children: [
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: 50,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  NotificationsContant(
                    title: title,
                    contant: contant,
                    date: date,
                    onTap: () {},
                  ),
                  Divider(
                    color: customColorDivider,
                    thickness: 1,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
