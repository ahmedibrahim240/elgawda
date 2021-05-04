import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/quizes.dart';
import 'package:flutter/material.dart';

class QuizesPage extends StatefulWidget {
  final List<Quizes> quizes;

  const QuizesPage({Key key, this.quizes}) : super(key: key);
  @override
  _QuizesPageState createState() => _QuizesPageState();
}

class _QuizesPageState extends State<QuizesPage> {
  int id;
  int id2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'Quizes')),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        primary: true,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListView(
            shrinkWrap: true,
            primary: false,
            children: [
              Center(
                child: Text(
                  widget.quizes[index].name,
                  style: AppTheme.headingColorBlue.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Center(
                child: Text(
                  widget.quizes[index].questions.length.toString() +
                      ' '
                          'question',
                  style: AppTheme.subHeading.copyWith(
                    color: customColorGold,
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: widget.quizes[index].questions.length,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                itemBuilder: (context, qindex) {
                  return ListView(
                    shrinkWrap: true,
                    primary: false,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${qindex + 1} - ",
                            style: AppTheme.headingColorBlue.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            widget.quizes[index].questions[qindex].text,
                            style: AppTheme.headingColorBlue.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      CustomRadioBattn(
                        anwsers: widget.quizes[index].questions[qindex].answers,
                      ),
                    ],
                  );
                },
              ),
              CustomButton(
                onPress: () {},
                text: getTranslated(context, 'save'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomRadioBattn extends StatefulWidget {
  final int answerId;
  final String title;
  final List<Answers> anwsers;

  const CustomRadioBattn({Key key, this.answerId, this.title, this.anwsers})
      : super(key: key);
  @override
  _CustomRadioBattnState createState() => _CustomRadioBattnState();
}

class _CustomRadioBattnState extends State<CustomRadioBattn> {
  int id;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      itemCount: widget.anwsers.length,
      itemBuilder: (context, index) {
        return RadioListTile(
          title: Text(
            widget.anwsers[index].text,
            style: AppTheme.headingColorBlue,
          ),
          activeColor: customColorGold,
          groupValue: id,
          onChanged: (val) {
            setState(() {
              id = val;
            });
          },
          value: widget.anwsers[index].id,
        );
      },
    );
  }
}
