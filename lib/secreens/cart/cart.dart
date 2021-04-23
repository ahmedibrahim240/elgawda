import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/models/courses.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Courses> _cartList = coursesList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: ListView(
        shrinkWrap: true,
        primary: false,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          Text(
            'Training Courses',
            style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
          ),
          ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: _cartList.length,
            itemBuilder: (context, index) {
              return trainingCourses(
                index: index,
                onTap: () {},
              );
            },
          ),
          Divider(
            color: customColor,
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Total',
                style: AppTheme.headingColorBlue.copyWith(fontSize: 16),
              ),
              SizedBox(width: 20),
              Text(
                '100 \$',
                style: AppTheme.headingColorBlue
                    .copyWith(fontSize: 16, color: customColorGold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  trainingCourses({int index, Function onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                      _cartList[index].image,
                    ),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width - 196,
                  child: Text(
                    _cartList[index].title,
                    style: AppTheme.headingColorBlue.copyWith(fontSize: 10),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 196,
                  child: Text(
                    _cartList[index].contant,
                    style: AppTheme.subHeading.copyWith(
                      fontSize: 9,
                      color: customColorGold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    RatingStar(
                      rating: _cartList[index].rate,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '${_cartList[index].rate}',
                      style: AppTheme.subHeading.copyWith(
                        fontSize: 10,
                        color: customColorGold,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      '(${_cartList[index].numPeopleRating})',
                      style: AppTheme.subHeading.copyWith(
                        fontSize: 10,
                        color: customColorGold,
                      ),
                    ),
                  ],
                ),
                Align(
                  child: Row(
                    children: [
                      SizedBox(width: 50),
                      Text(
                        'Pri',
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        '${_cartList[index].newPrice}\$',
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '${_cartList[index].oldPrice}\$',
                        style: AppTheme.headingColorBlue.copyWith(
                          fontSize: 12,
                          decoration: TextDecoration.lineThrough,
                          color: customColor.withOpacity(.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Center(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _cartList.remove(_cartList[index]);
                  });
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.red,
                  size: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
