import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Answers {
  final int id;
  final String text;
  final String correct;

  Answers({this.id, this.text, this.correct});
}

class Questions {
  final int id;
  final String text;
  final String mark;

  final List<Answers> answers;

  Questions({this.id, this.text, this.answers, this.mark});
}

class Quizes {
  final int id;
  final String name;
  final int totlaMark;
  final int userMark;

  final List<Questions> questions;

  Quizes({this.id, this.name, this.questions, this.totlaMark, this.userMark});
}

class Sections {
  final int id;
  final String name;

  final List<Quizes> quizes;

  Sections({this.id, this.name, this.quizes});
}

class UsersAnswes {
  final Quizes quizes;

  UsersAnswes({this.quizes});
}

class QuizesApi {
  static Future<List<UsersAnswes>> fetchMyCQuiszes() async {
    List<Answers> listOfAnswers = [];
    List<UsersAnswes> listOfUsersAnswes = [];
    List<Questions> listOfQuestions = [];

    try {
      var response = await http.get(
        Utils.QuizAnssers_URL,
        headers: {
          'x-api-key': User.userToken,
          'lang': apiLang(),
        },
      );
      var jsonData = json.decode(response.body);
      print('MyCourses:${response.statusCode}');
      for (var quize in jsonData['data']) {
        listOfQuestions = [];
        for (var ques in quize['quiz']['questions']) {
          listOfAnswers = [];
          for (var ans in ques['answers']) {
            Answers answers = Answers(
              id: ans['id'],
              text: ans['text'],
              correct: ans['correct'],
            );
            listOfAnswers.add(answers);
          }
          Questions questions = Questions(
            id: ques['id'],
            text: ques['text'],
            mark: ques['mark'],
            answers: listOfAnswers,
          );
          listOfQuestions.add(questions);
        }
        Quizes quizes = Quizes(
          questions: listOfQuestions,
          id: quize['quiz']['id'],
          name: quize['quiz']['name'],
          totlaMark: quize['quiz']['total_mark'],
          userMark: quize['user_mark'],
        );

        UsersAnswes userAnswers = UsersAnswes(
          quizes: quizes,
        );
        listOfUsersAnswes.add(userAnswers);
      }

      if (response.statusCode == 200) {}
    } catch (e) {
      print('home Qwizes Ansser errrrrrrrrrrrrrrrrror');

      print(e);
    }
    return listOfUsersAnswes;
  }
}
