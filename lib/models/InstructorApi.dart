import 'package:elgawda/models/utils.dart';
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
  final String name;
  final String mp4Link;
  // ignore: non_constant_identifier_names
  final String promo_video;
  final String instructorName;
  // ignore: non_constant_identifier_names
  final String vimeo_code;
  // ignore: non_constant_identifier_names
  final String image_path;
  final String badges;
  final String description;
  final String rate;
  final String discount;
  var sections;

  final String price;

  CouresesModels({
    this.id,
    this.name,
    this.description,
    this.mp4Link,
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

    try {
      var response = await http.get(Utils.Instructors_URL);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']) {
          listOfInstructorCoureses = [];
          for (var cours in items['courses']) {
            CouresesModels coureses = CouresesModels(
              id: cours['id'],
              description: cours['description'],
              rate_count: cours['rate_count'],
              name: cours['name'],
              mp4Link: cours['video_qualities'][0]['url'],
              instructorName: cours['instructor']['name'],
              image_path: cours['image_path'],
              vimeo_code: cours['vimeo_code'],
              promo_video: cours['promo_video'],
              badges: cours['badges'],
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

    try {
      var response = await http.get(Utils.HOME_URL);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var items in jsonData['data']['instructors']) {
          listOfInstructorCoureses = [];
          for (var cours in items['courses']) {
            CouresesModels coureses = CouresesModels(
              id: cours['id'],
              description: cours['description'],
              rate_count: cours['rate_count'],
              name: cours['name'],
              mp4Link: cours['video_qualities'][0]['url'],
              instructorName: cours['instructor']['name'],
              image_path: cours['image_path'],
              vimeo_code: cours['vimeo_code'],
              promo_video: cours['promo_video'],
              badges: cours['badges'],
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
