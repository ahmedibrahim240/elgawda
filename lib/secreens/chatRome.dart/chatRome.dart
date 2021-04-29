import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/chetApi.dart';
import 'package:elgawda/models/userData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elgawda/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatRome extends StatefulWidget {
  @override
  _ChatRomeState createState() => _ChatRomeState();
}

class _ChatRomeState extends State<ChatRome> {
  List<String> messageList = [];
  TextEditingController _messageController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 360,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              primary: false,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              children: [
                FutureBuilder(
                  future: ChatApi.fetchAllMyMassege(14),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return (snapshot.data.isEmpty)
                          ? Container()
                          : ListView.builder(
                              shrinkWrap: true,
                              primary: false,
                              itemCount: messageList.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(snapshot.data[index].message),
                                    SizedBox(height: 20),
                                  ],
                                );
                              },
                            );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ],
            ),
          ),
          messageTextFiled(),
        ],
      ),
    );
  }

  Container serviesMessage({String message}) {
    return Container(
      height: 40,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: customColorbottomBar,
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          message,
          textDirection: TextDirection.ltr,
          style: AppTheme.subHeadingColorBlue,
        ),
      ),
    );
  }

  Container messageTextFiled() {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: 10),
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: customColorGray),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              maxLines: null,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: (loading) ? 'Sendig ....' : 'Write a message....',
                hintStyle: AppTheme.subHeading.copyWith(
                  fontSize: 10,
                  color: customColorIcon,
                ),
                fillColor: Colors.white,
                contentPadding: EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.transparent,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: () {
              setState(() {
                loading = !loading;
                _messageController.text = '';
                sentMessage(_messageController.text);
              });
            },
            child: Container(
              child: Icon(
                Icons.send,
                color: customColorIcon,
              ),
            ),
          ),
        ],
      ),
    );
  }

  sentMessage(String message) async {
    try {
      var response = await http.post(
        Utils.Chat_URL + "/14/send",
        body: {
          'message': message,
        },
        headers: {
          'x-api-key': User.userToken,
        },
      );
      print(response.statusCode);

      Map<String, dynamic> map = json.decode(response.body);
      print(map);
      setState(
        () async {
          if (map['success'] == false) {
            setState(() {
              loading = !loading;
            });
            showMyDialog(context: context, message: map['message'].toString());
          } else {
            setState(() {
              loading = !loading;
            });
            showMyDialog(context: context, message: 'Massge Was Send');
          }
        },
      );
      // Navigator.pop(context);
    } catch (e) {
      setState(() {
        loading = !loading;
      });
      print(
          'Catchhhhhhhhhhhhhhhhhhhhhhh errororororrorrorooroeoreoroeroeorero');
      print(e.toString());
    }
  }
}
