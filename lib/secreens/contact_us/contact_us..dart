import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  List<String> messageList = [];
  TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              primary: true,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              children: [
                (messageList.isEmpty)
                    ? Column(
                        children: [
                          serviesMessage(
                            message: 'مرحبا .لسف يوجد احد متصل حاليا',
                          ),
                          SizedBox(height: 20),
                          serviesMessage(
                            message: 'كيف يمكنا مساعدتك حين معاودها الاتصال ؟',
                          ),
                        ],
                      )
                    : Container(),
                ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: messageList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(messageList[index]),
                        SizedBox(height: 20),
                      ],
                    );
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
                hintText: '....write a message',
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
                messageList.add(_messageController.text);
                _messageController.text = '';
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
}
