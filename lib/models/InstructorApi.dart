import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/models/quizes.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/models/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InstructorModels {
  final int id;
  final String name;
  final String bio;
  final String job;
  // ignore: non_constant_identifier_names
  final String image_path;
  List<CouresesModels> courses;
  InstructorModels({
    this.id,
    this.name,
    this.bio,
    this.job,
    // ignore: non_constant_identifier_names
    this.image_path,
    this.courses,
  });
}

class CouresesModels {
  final int id;
  // ignore: non_constant_identifier_names
  final int rate_count;
  final int enrolled;
  final String name;
  // ignore: non_constant_identifier_names
  final String promo_video;
  final List<Sections> sectionsList;
  final String instructorName;
  // ignore: non_constant_identifier_names
  final int in_wish_list;
  // ignore: non_constant_identifier_names
  final String vimeo_code;
  // ignore: non_constant_identifier_names
  final String image_path;
  final String badges;
  final String description;
  final String rate;
  final String discount;
  // ignore: non_constant_identifier_names
  final String discount_message;
  var sections;
  // ignore: non_constant_identifier_names
  final int total_quizes;
  // ignore: non_constant_identifier_names
  final String total_time;
  // ignore: non_constant_identifier_names
  final int total_files;
  // ignore: non_constant_identifier_names
  final String website_link;

  final String price;

  CouresesModels({
    @required this.enrolled,
    @required this.sectionsList,
    // ignore: non_constant_identifier_names
    this.total_quizes,
    // ignore: non_constant_identifier_names
    @required this.in_wish_list,
    // ignore: non_constant_identifier_names
    this.discount_message,
    // ignore: non_constant_identifier_names
    this.website_link,
    // ignore: non_constant_identifier_names
    this.total_time,
    // ignore: non_constant_identifier_names
    this.total_files,
    this.id,
    this.name,
    this.description,
    // ignore: non_constant_identifier_names
    this.rate_count,
    this.instructorName,
    this.sections,

    // ignore: non_constant_identifier_names
    this.vimeo_code,
    // ignore: non_constant_identifier_names
    this.image_path,
    // ignore: non_constant_identifier_names
    this.promo_video,
    this.badges,
    this.rate,
    this.discount,
    this.price,
  });
}

class InstructorApi {
  static Future<List<InstructorModels>> fetchALLInstructor() async {
    List<InstructorModels> listOfInstructor = [];
    List<CouresesModels> listOfInstructorCoureses = [];
    List<Answers> listOfAnswers = [];
    List<Questions> listOfQuestions = [];
    List<Quizes> listOfQuizes = [];
    List<Sections> listOfSections = [];

    try {
      var response = await http.get(
        Utils.Instructors_URL,
        headers: {
          'lang': apiLang(),
          'x-api-key': User.userToken,
        },
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          listOfInstructorCoureses = [];
          for (var cours in items['courses']) {
            listOfSections = [];
            for (var sec in cours['sections']) {
              listOfQuizes = [];

              for (var qui in sec['quizes']) {
                listOfQuestions = [];
                for (var ques in qui['questions']) {
                  listOfAnswers = [];
                  for (var ans in ques['answers']) {
                    Answers answers = Answers(
                      id: ans['id'],
                      text: ans['text'],
                    );
                    listOfAnswers.add(answers);
                  }
                  Questions questions = Questions(
                    answers: listOfAnswers,
                    id: ques['id'],
                    text: ques['text'],
                    mark: ques['mark'],
                  );
                  listOfQuestions.add(questions);
                }
                Quizes quizes = Quizes(
                  id: qui['id'],
                  name: qui['name'],
                  totlaMark: qui['total_mark'],
                  questions: listOfQuestions,
                );
                listOfQuizes.add(quizes);
              }
              Sections sections = Sections(
                id: sec['id'],
                name: sec['name'],
                quizes: listOfQuizes,
              );
              listOfSections.add(sections);
            }
            CouresesModels coureses = CouresesModels(
              id: cours['id'],
              enrolled: cours['enrolled'],
              in_wish_list: cours['in_wish_list'],
              description: cours['description'],
              rate_count: cours['rate_count'],
              name: cours['name'],
              discount_message: cours['discount_message'],
              website_link: cours['website_link'],
              instructorName: cours['instructor']['name'],
              total_files: cours['featured_data']['total_files'],
              total_time: cours['featured_data']['total_time'],
              total_quizes: cours['featured_data']['total_quizes'],
              image_path: cours['image_path'],
              vimeo_code: cours['vimeo_code'],
              promo_video: cours['promo_video'],
              badges: cours['badges'],
              sectionsList: listOfSections,
              rate: cours['rate'],
              price: cours['price'],
              sections: cours['sections'],
              discount: cours['discount'],
            );

            listOfInstructorCoureses.add(coureses);
          }
          InstructorModels instructor = InstructorModels(
            id: items['id'],
            name: items['name'],
            bio: items['bio'],
            image_path: items['image_path'],
            job: items['job'],
            courses: listOfInstructorCoureses,
          );
          listOfInstructor.add(instructor);
        }
      }
    } catch (e) {
      print('home slider errror');

      print(e);
    }
    return listOfInstructor;
  }

  static Future<List<InstructorModels>> fetchInstructor() async {
    List<InstructorModels> listOfInstructor = [];
    List<CouresesModels> listOfInstructorCoureses = [];
    List<Answers> listOfAnswers = [];
    List<Questions> listOfQuestions = [];
    List<Quizes> listOfQuizes = [];
    List<Sections> listOfSections = [];

    try {
      var response = await http.get(
        Utils.HOME_URL,
        headers: {
          'lang': apiLang(),
          'x-api-key': User.userToken,
        },
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']['instructors']) {
          listOfInstructorCoureses = [];
          for (var cours in items['courses']) {
            listOfSections = [];
            for (var sec in cours['sections']) {
              listOfQuizes = [];

              for (var qui in sec['quizes']) {
                listOfQuestions = [];
                for (var ques in qui['questions']) {
                  listOfAnswers = [];
                  for (var ans in ques['answers']) {
                    Answers answers = Answers(
                      id: ans['id'],
                      text: ans['text'],
                    );
                    listOfAnswers.add(answers);
                  }
                  Questions questions = Questions(
                    answers: listOfAnswers,
                    id: ques['id'],
                    text: ques['text'],
                    mark: ques['mark'],
                  );
                  listOfQuestions.add(questions);
                }
                Quizes quizes = Quizes(
                  id: qui['id'],
                  name: qui['name'],
                  totlaMark: qui['total_mark'],
                  questions: listOfQuestions,
                );
                listOfQuizes.add(quizes);
              }
              Sections sections = Sections(
                id: sec['id'],
                name: sec['name'],
                quizes: listOfQuizes,
              );
              listOfSections.add(sections);
            }
            CouresesModels coureses = CouresesModels(
              id: cours['id'],
              enrolled: cours['enrolled'],
              in_wish_list: cours['in_wish_list'],
              description: cours['description'],
              rate_count: cours['rate_count'],
              name: cours['name'],
              discount_message: cours['discount_message'],
              website_link: cours['website_link'],
              instructorName: cours['instructor']['name'],
              total_files: cours['featured_data']['total_files'],
              total_time: cours['featured_data']['total_time'],
              total_quizes: cours['featured_data']['total_quizes'],
              image_path: cours['image_path'],
              vimeo_code: cours['vimeo_code'],
              promo_video: cours['promo_video'],
              badges: cours['badges'],
              sectionsList: listOfSections,
              rate: cours['rate'],
              price: cours['price'],
              sections: cours['sections'],
              discount: cours['discount'],
            );

            listOfInstructorCoureses.add(coureses);
          }
          InstructorModels instructor = InstructorModels(
            id: items['id'],
            name: items['name'],
            bio: items['bio'],
            image_path: items['image_path'],
            job: items['job'],
            courses: listOfInstructorCoureses,
          );
          listOfInstructor.add(instructor);
        }
      }
    } catch (e) {
      print('home slider errror');

      print(e);
    }
    return listOfInstructor;
  }
}
