import 'package:elgawda/models/courses.dart';

class Categories {
  final String name;
  final String badge;
  final List<Courses> courses;

  Categories({this.name, this.courses, this.badge});
}

List<Categories> categoriesList = [
  Categories(
    name: 'C#',
    badge: 'Bestseller',
    courses: coursesList,
  ),
  Categories(
    name: 'C++',
    courses: coursesList,
  ),
  Categories(
    name: 'C',
    badge: 'Sale',
    courses: coursesList,
  ),
  Categories(
    name: 'java Script',
    badge: 'Recent',
    courses: coursesList,
  ),
  Categories(
    name: 'HTML',
    badge: 'Bestseller',
    courses: coursesList,
  ),
  Categories(
    name: 'CCNN',
    badge: 'Bestseller',
    courses: coursesList,
  ),
];
