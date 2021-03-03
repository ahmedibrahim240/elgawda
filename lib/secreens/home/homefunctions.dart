import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/courses.dart';
import 'package:elgawda/secreens/cart/cart.dart';
import 'package:elgawda/secreens/editprofile/editprofile.dart';
import 'package:elgawda/secreens/featuredCourses/featuredCoursesedtails.dart';
import 'package:elgawda/secreens/notifications/notifications.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Container sectionTitle({String title, Function onTap}) {
  return Container(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
          ),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(
            'View All',
            style: AppTheme.subHeading.copyWith(
              fontSize: 12,
              color: customColorGold,
            ),
          ),
        ),
      ],
    ),
  );
}

//////////////////////////////////////////////////////////////////////
featuredSections() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Featured',
        style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
      ),
      SizedBox(height: 10),
      Container(
        margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        height: 300,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: coursesList.length,
          itemBuilder: (context, index) {
            return featuerd(
              index: index,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => FeaturedCoursesedtails(
                      courses: coursesList[index],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    ],
  );
}

//////////////////////////////////////////////////////////////////////

featuerd({int index, Function onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      width: 180,
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(
                    coursesList[index].image,
                  ),
                  fit: BoxFit.cover),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              coursesList[index].title,
              style: AppTheme.headingColorBlue.copyWith(fontSize: 12),
            ),
          ),
          Text(
            coursesList[index].lecTitle,
            style: AppTheme.subHeading.copyWith(
              fontSize: 10,
              color: customColorGold,
            ),
          ),
          Row(
            children: [
              RatingStar(
                rating: coursesList[index].rate,
              ),
              SizedBox(width: 5),
              Text(
                '${coursesList[index].rate}',
                style: AppTheme.subHeading.copyWith(
                  fontSize: 10,
                  color: customColorGold,
                ),
              ),
              SizedBox(width: 5),
              Text(
                '(${coursesList[index].numPeopleRating})',
                style: AppTheme.subHeading.copyWith(
                  fontSize: 10,
                  color: customColorGold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Pri',
                style: AppTheme.headingColorBlue.copyWith(
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 10),
              Text(
                '${coursesList[index].newPrice}\$',
                style: AppTheme.headingColorBlue.copyWith(
                  fontSize: 12,
                ),
              ),
              SizedBox(width: 5),
              Text(
                '${coursesList[index].oldPrice}\$',
                style: AppTheme.headingColorBlue.copyWith(
                  fontSize: 12,
                  decoration: TextDecoration.lineThrough,
                  color: customColor.withOpacity(.5),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
//////////////////////////////////////////////////////////////////////

homePoster(BuildContext context) {
  return Container(
    height: 150,
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      image: DecorationImage(
        image: AssetImage('lib/images/aboutus.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.0),
          bottomRight: Radius.circular(20.0),
        ),
        gradient: LinearGradient(
          colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          'Curved AppBar Exemple',
          style: AppTheme.heading.copyWith(color: customColorbottomBar),
        ),
      ),
    ),
  );
}
//////////////////////////////////////////////////////////////////////

homeAppBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
    leading: InkWell(
      onTap: () {
        flitter(
          context: context,
          child: EditProfile(),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: CircleAvatar(
          maxRadius: 50,
          backgroundColor: customColor,
          backgroundImage: AssetImage('lib/images/user.jpg'),
        ),
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {},
          child: Icon(
            Icons.search,
            color: customColorDivider,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Notificatios(),
              ),
            );
          },
          child: Icon(
            Icons.notifications,
            color: customColor,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => Cart(),
              ),
            );
          },
          child: Icon(
            FontAwesomeIcons.shoppingCart,
            color: customColor,
          ),
        ),
      ),
    ],
  );
}

/////////////////////////////
