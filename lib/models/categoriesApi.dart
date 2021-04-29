import 'package:elgawda/models/InstructorApi.dart';
import 'package:elgawda/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CategoriesModels {
  final int id;
  final List<SubCategoriesModels> subcategories;
  final String name;
  final String image;

  CategoriesModels({
    this.id,
    this.name,
    this.image,
    this.subcategories,
  });
}

class SubCategoriesModels {
  final int id;
  final String name;
  final String image;

  SubCategoriesModels({
    this.id,
    this.name,
    this.image,
  });
}

class CategoriesApi {
  static Future<String> getVideoMp4Link({var id}) async {
    String link;
    try {
      var response = await http.get(
        'https://player.vimeo.com/video/$id/config',
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var url in jsonData['request']['files']['progressive']) {
          if (url['quality'] == "360p") {
            link = url['url'];
          } else if (url['quality'] == "240p") {
            link = url['url'];
          }
        }

        print('link:$link');
      }
    } catch (e) {
      print(e);
    }
    return link;
  }

  static Future<List<CategoriesModels>> fetchAllCategories() async {
    List<CategoriesModels> listOfCategoriesModels = [];
    List<SubCategoriesModels> listOfSubCategoriesModels = [];

    try {
      var response = await http.get(Utils.Categories_URL);
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var cours in jsonData['data']) {
          listOfSubCategoriesModels = [];
          for (var sub in cours['subcategories']) {
            SubCategoriesModels categories = SubCategoriesModels(
              id: sub['id'],
              name: sub['name'],
              image: sub['image'],
            );
            listOfSubCategoriesModels.add(categories);
          }
          CategoriesModels categories = CategoriesModels(
            id: cours['id'],
            name: cours['name'],
            image: cours['image'],
            subcategories: listOfSubCategoriesModels,
          );
          listOfCategoriesModels.add(categories);
        }
      }
    } catch (e) {
      print('All Gater errror');

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
            discount_message: cours['discount_message'],
            website_link: cours['website_link'],
            mp4Link: cours['video_qualities'][0]['url'],
            instructorName: cours['instructor']['name'],
            total_files: cours['featured_data']['total_files'],
            total_time: cours['featured_data']['total_time'],
            total_quizes: cours['featured_data']['total_quizes'],
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
