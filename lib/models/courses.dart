class Courses {
  final String title;
  final String lecTitle;
  final String contant;
  final String image;
  final String badge;

  final double rate;
  final double numPeopleRating;
  final double oldPrice;
  final double newPrice;

  Courses({
    this.image,
    this.badge,
    this.title,
    this.lecTitle,
    this.contant,
    this.rate,
    this.numPeopleRating,
    this.oldPrice,
    this.newPrice,
  });
}

List<Courses> coursesList = [
  Courses(
    badge: 'Bestseller',
    title: 'UThe complete Digital',
    contant: 'Master Digital Marketing StrategySocial media email&more',
    lecTitle: 'Ryan Kroonenburg',
    image:
        'https://images.pexels.com/photos/577585/pexels-photo-577585.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    rate: 5.0,
    newPrice: 49.99,
    oldPrice: 55.99,
    numPeopleRating: 197.75,
  ),
  Courses(
    badge: 'Recent',
    title: 'The complete Digital',
    contant: 'Master Digital Marketing StrategySocial media email&more',
    lecTitle: 'Ryan Kroonenburg',
    image:
        'https://images.pexels.com/photos/169573/pexels-photo-169573.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    rate: 4.5,
    newPrice: 49.99,
    oldPrice: 55.99,
    numPeopleRating: 197.75,
  ),
  Courses(
    title: 'The complete Digital',
    badge: 'Sale',
    contant: 'Master Digital Marketing StrategySocial media email&more',
    lecTitle: 'Ryan Kroonenburg',
    image:
        'https://images.pexels.com/photos/574071/pexels-photo-574071.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    rate: 3.5,
    newPrice: 49.99,
    oldPrice: 55.99,
    numPeopleRating: 197.75,
  ),
  Courses(
    title: 'The complete Digital',
    badge: 'Bestseller',
    contant: 'Master Digital Marketing StrategySocial media email&more',
    lecTitle: 'Ryan Kroonenburg',
    image:
        'https://images.pexels.com/photos/97077/pexels-photo-97077.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    rate: 4.6,
    newPrice: 49.99,
    oldPrice: 55.99,
    numPeopleRating: 197.75,
  ),
  Courses(
    title: 'The complete Digital',
    badge: 'Sale',
    contant: 'Master Digital Marketing StrategySocial media email&more',
    lecTitle: 'Ryan Kroonenburg',
    image:
        'https://images.pexels.com/photos/270366/pexels-photo-270366.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    rate: 2.0,
    newPrice: 49.99,
    oldPrice: 55.99,
    numPeopleRating: 197.75,
  ),
  Courses(
    title: 'The complete Digital',
    badge: 'Recent',
    contant: 'Master Digital Marketing StrategySocial media email&more',
    lecTitle: 'Ryan Kroonenburg',
    image:
        'https://images.pexels.com/photos/546819/pexels-photo-546819.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    rate: 4.0,
    newPrice: 49.99,
    oldPrice: 55.99,
    numPeopleRating: 197.75,
  ),
];
