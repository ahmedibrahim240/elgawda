import 'package:elgawda/models/InstructorApi.dart';
import 'package:elgawda/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FeaturedCoursesApi {
  static Future<List<CouresesModels>> fetchFeaturedCourses() async {
    List<CouresesModels> listOfCoureses = [];

    try {
      var response = await http.get(Utils.HOME_URL);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var cours in jsonData['data']['featured_courses']) {
          CouresesModels coureses = CouresesModels(
            id: cours['id'],
            description: cours['description'],
            rate_count: cours['rate_count'],
            name: cours['name'],
            instructorName: cours['instructor']['name'],
            image_path: cours['image_path'],
            vimeo_code: cours['vimeo_code'],
            badges: cours['badges'],
            rate: cours['rate'],
            price: cours['price'],
            sections: cours['sections'],
            discount: cours['discount'],
          );
          listOfCoureses.add(coureses);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfCoureses;
  }
}
