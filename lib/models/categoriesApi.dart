import 'package:elgawda/models/InstructorApi.dart';
import 'package:elgawda/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesModels {
  final int id;
  var subcategories;
  final String name;
  final String image;

  CategoriesModels({
    this.id,
    this.name,
    this.image,
    this.subcategories,
  });
}

class CategoriesApi {
  static Future<List<CategoriesModels>> fetchAllCategories() async {
    List<CategoriesModels> listOfCategoriesModels = [];

    try {
      var response = await http.get(Utils.Categories_URL);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var cours in jsonData['data']) {
          CategoriesModels categories = CategoriesModels(
            id: cours['id'],
            name: cours['name'],
            image: cours['image'],
            subcategories: cours['subcategories'],
          );
          listOfCategoriesModels.add(categories);
        }
      }
    } catch (e) {
      print('home slider errror');

      print(e);
    }
    return listOfCategoriesModels;
  }

  static Future<List<CouresesModels>> fetchCategrsCoursesByid(int id) async {
    List<CouresesModels> listOfCoureses = [];

    try {
      var response = await http.get(Utils.Categories_URL + '/$id');
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var cours in jsonData['data']['courses']) {
          CouresesModels coureses = CouresesModels(
            id: cours['id'],
            description: cours['description'],
            rate_count: cours['rate_count'],
            name: cours['name'],
            mp4Link: cours['video_qualities'][0]['url'],
            // instructorName: cours['instructor'][0]['name'],
            image_path: cours['image_path'],
            vimeo_code: cours['vimeo_code'],
            promo_video: cours['promo_video'],
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
      print('home slider errror');

      print(e);
    }
    return listOfCoureses;
  }
}
