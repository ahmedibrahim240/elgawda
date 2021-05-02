import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/notificationsApi.dart';
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
      appBar: AppBar(
          title: Text(
        getTranslated(context, 'notifications'),
      )),
      body: FutureBuilder(
        future: NotificationsApi.fetchAllMyNotifications(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return (snapshot.data.isEmpty)
                ? Container()
                : ListView.builder(
                    shrinkWrap: true,
                    primary: true,
                    itemCount: snapshot.data.length,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    itemBuilder: (context, index) {
                      print(snapshot.data[index].body);
                      return Column(
                        children: [
                          NotificationsContant(
                            title: snapshot.data[index].title,
                            contant: snapshot.data[index].body,
                            date: snapshot.data[index].created_at,
                            onTap: () {},
                          ),
                          Divider(
                            color: customColorDivider,
                            thickness: 1,
                          ),
                        ],
                      );
                    },
                  );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
