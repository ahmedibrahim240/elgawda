import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/models/InstructorApi.dart';
import 'package:elgawda/models/categoriesApi.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/models/utils.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeDaTaApi {
  //HOME featured_courses

  static Future<List<CouresesModels>> fetchFeaturedCourses() async {
    List<CouresesModels> listOfCoureses = [];

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
        for (var cours in jsonData['data']['featured_courses']) {
          CouresesModels coureses = CouresesModels(
            id: cours['id'],
            in_wish_list: cours['in_wish_list'],
            enrolled: cours['enrolled'],
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

  //HOME SLIDER
  static Future<List<CouresesModels>> fetchHomeSlider() async {
    List<CouresesModels> listOfCoureses = [];

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
        for (var cours in jsonData['data']['slider']) {
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

  static Future<List<CategoriesModels>> fetchHomeCategories() async {
    List<CategoriesModels> listOfCategoriesModels = [];
    List<SubCategoriesModels> listOfSubCategoriesModels = [];

    try {
      var response = await http.get(
        Utils.Categories_URL,
        headers: {
          'x-api-key': User.userToken,
          'lang': apiLang(),
        },
      );
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
      print('home GAtro errror');

      print(e);
    }
    return listOfCategoriesModels;
  }

  static Future<List<CouresesModels>> cursesSearch(String name) async {
    List<CouresesModels> listOfCourses = [];

    try {
      var response = await http.get(
        Utils.HOMESearch_URL + "?search=$name",
        headers: {
          'x-api-key': User.userToken,
          'lang': apiLang(),
        },
      );
      var jsonData = json.decode(response.body);
      if (response.statusCode == 200) {
        for (var cours in jsonData['data']) {
          CouresesModels coureses = CouresesModels(
            id: cours['id'],
            in_wish_list: cours['in_wish_list'],
            description: cours['description'],
            enrolled: cours['enrolled'],
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
            rate: cours['rate'],
            price: cours['price'],
            sections: cours['sections'],
            discount: cours['discount'],
          );
          listOfCourses.add(coureses);
        }
      }
    } catch (e) {
      print(e);
    }
    return listOfCourses;
  }
}
