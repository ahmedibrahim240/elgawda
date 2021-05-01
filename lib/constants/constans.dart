import 'package:cached_network_image/cached_network_image.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/models/userData.dart';
import 'package:elgawda/secreens/cart/cart.dart';
import 'package:elgawda/secreens/editprofile/editprofile.dart';
import 'package:elgawda/secreens/home/coursesSearch.dart';
import 'package:elgawda/secreens/notifications/notifications.dart';
import 'package:elgawda/secreens/wrapper/wrapper.dart';
import 'package:elgawda/services/UserData.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html/parser.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:url_launcher/url_launcher.dart';

import '../sharedPreferences.dart';
// import 'package:flutter_share/flutter_share.dart';

const customColor = Color(0xfff21496C);
const customColorGold = Color(0xfff8e0048);
const sliderTextColor = Color(0xfff21496C);
const sliderTextColorcontaint = Color(0xfff21496C);
const customColorIcon = Color(0xfff7D7D7D);
const customColorDivider = Color(0xfffe1e1e1);
const customColorGray = Color(0xfff7d7d7d);
const customColorbottomBar = Color(0xfffDBD8D2);
////////////////////////////////////////
Future<Null> customOnRefresh(
    {Function onRefresh, Function affterRefresh}) async {
  onRefresh();

  await Future.delayed(
    Duration(seconds: 2),
    affterRefresh,
  );
  return null;
}

////////////////////////////////////////////////////////////

class LogoContainar extends StatelessWidget {
  const LogoContainar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('lib/images/logo.png'),
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body.text).documentElement.text;

  return parsedString;
}

String gitnewPrice({String descaound, String price}) {
  double oldPrice;
  oldPrice = double.parse(price) - double.parse(descaound);
  return oldPrice.toString();
}

String apiLang() {
  switch (User.appLang) {
    case 'ar_EG':
      return 'ar';
      break;
    default:
      return 'en';
  }
}

/////////////////////////////////////
customCachedNetworkImage({String url, BuildContext context, BoxFit boxFit}) {
  try {
    if (url == null || url == '') {
      return Container();
    } else {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: (Uri.parse(url).isAbsolute)
            ? CachedNetworkImage(
                imageUrl: url,
                fit: (boxFit) ?? BoxFit.contain,
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              )
            : Icon(
                Icons.image,
                color: customColor,
              ),
      );
    }
  } catch (e) {
    print(e.toString());
  }
}

/////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
Future<void> showMyDialog({
  BuildContext context,
  String message,
  Function onTap,
  String buttonText,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  getTranslated(context, 'AdministrativeMessage'),
                  style: AppTheme.heading.copyWith(
                    color: customColor,
                  ),
                ),
              ),
              Text(
                message,
                style: AppTheme.subHeading,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              buttonText ?? getTranslated(context, 'Close'),
              style: AppTheme.heading.copyWith(
                color: customColor,
              ),
            ),
            onPressed: onTap ??
                () {
                  Navigator.of(context).pop();
                },
          ),
        ],
      );
    },
  );
}

//////////////////////////////////////////////////////////
PreferredSizeWidget customAppBar({String title}) => AppBar(
      centerTitle: true,
      toolbarHeight: 70,
      backgroundColor: customColor,
      title: Text(
        title,
        style: AppTheme.heading.copyWith(
          color: Colors.white,
        ),
      ),
    );

//////////////////////////////////////////////////////
class MyCliper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2 - 150, size.height / 2,
        size.width / 2, size.height / 2 + 30);

    path.quadraticBezierTo(
        size.width, size.height - 60, size.width + 80, size.height / 2 - 150);

    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

/////////////////////////////////////////////////////////////////////////////////
class CustomButton extends StatelessWidget {
  final String text;
  final Function onPress;
  CustomButton({this.onPress, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(10),
        color: customColor,
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 150,
          height: 48,
          child: Text(
            text,
            style: AppTheme.heading.copyWith(
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////////////////////

class CustomButtonWithchild extends StatelessWidget {
  final Widget child;
  final Color color;
  final Function onPress;
  CustomButtonWithchild({this.onPress, this.child, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(30),
        color: color,
        child: MaterialButton(
          onPressed: onPress,
          minWidth: double.infinity,
          height: 48,
          child: child,
        ),
      ),
    );
  }
}
/////////////////////////////////////////////////////////////////////////////////

void showSettingsPanel(
    {@required BuildContext context, @required Widget child}) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    enableDrag: true,
    builder: (context) {
      return child;
    },
  );
}

/////////////////////////////////////////////////////////////////////////////////
newPrice({double price, double dis}) {
  return price - dis;
}

/////////////////////////////////////////////////////////////////////////////////
homeAppBar({BuildContext context, Widget title}) {
  return AppBar(
    toolbarHeight: 80,
    title: title,
    leading: InkWell(
      onTap: () {
        flitter(
          context: context,
          child: EditProfile(),
        );
      },
      child: StreamBuilder<Users>(
        stream: DatabaseServices(context: context, userToken: User.userToken)
            .userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Users users = snapshot.data;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Hero(
                tag: 'UserImage',
                child: CircleAvatar(
                  maxRadius: 50,
                  backgroundColor: customColor,
                  backgroundImage: (users.image != '' && users.image != null)
                      ? NetworkImage(users.image)
                      : AssetImage(
                          'lib/images/man.png',
                        ),
                ),
              ),
            );
          } else {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            showSearch(
              context: context,
              delegate: CoursesSearch(),
            );
          },
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

/////////////////////////////////////////////////////////////////////////////////
customRaiseButtom({String text, Function onTap}) {
  return RaisedButton(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    color: customColor,
    onPressed: onTap,
    child: Text(
      text,
      style: AppTheme.subHeading.copyWith(
        color: Colors.white,
      ),
    ),
  );
}

Future<void> cardDialog({BuildContext context, String message}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Center(
                child: Text(
                  (message) ??
                      'تم اضافة الطلب لإستكمال  عمليه الشراء عليك  الذهاب الي عربة التسوق',
                  style: AppTheme.subHeading,
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              getTranslated(context, 'home'),
              style: AppTheme.heading.copyWith(
                color: customColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => Wrapper()),
                (route) => false,
              );
            },
          ),
          TextButton(
            child: Text(
              getTranslated(context, 'cart'),
              style: AppTheme.heading.copyWith(
                color: customColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (_) => Cart(),
                ),
                ModalRoute.withName('/'),
              );
            },
          ),
        ],
      );
    },
  );
}

////////////////////////////////////////////////////////////////////////
increaseCartTotlaPrice({double price}) async {
  print('increaseCartTotlaPrice:$price');
  double totalParice;
  totalParice = Cart.totalPraices + price;

  MySharedPreferences.saveTotalPrice(totalParice);
  Cart.totalPraices = await MySharedPreferences.getTotalPrice();
}

decreaseCartTotlaPrice({double price}) async {
  double totalParice;
  totalParice = Cart.totalPraices - price;
  MySharedPreferences.saveTotalPrice(totalParice);
  Cart.totalPraices = await MySharedPreferences.getTotalPrice();
}

class CustomCarouselSlider extends StatefulWidget {
  final bool reverse;
  final Function onTap;
  final List<dynamic> listOfObject;

  const CustomCarouselSlider({
    Key key,
    @required this.listOfObject,
    @required this.reverse,
    @required this.onTap,
  }) : super(key: key);

  @override
  _CustomCarouselSliderState createState() => _CustomCarouselSliderState();
}

class _CustomCarouselSliderState extends State<CustomCarouselSlider> {
  @override
  Widget build(BuildContext context) {
    final List<dynamic> offer = widget.listOfObject;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlayInterval: Duration(seconds: 2),
                autoPlay: true,
                reverse: widget.reverse,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
              ),
              items: offer
                  .map(
                    (items) => Container(
                      child: Container(
                        margin: EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  width: 300,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        items.imgUrl,
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Container(
                                    height: 100,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(20.0),
                                        bottomRight: Radius.circular(20.0),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(200, 0, 0, 0),
                                          Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        SizedBox(height: 40),
                                        Text(
                                          items.contant,
                                          style: TextStyle(
                                            color: Colors.deepOrangeAccent,
                                            fontSize: 25,
                                          ),
                                        ),
                                        Text(
                                          items.title,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////
class RatingStar extends StatelessWidget {
  final double rating;

  const RatingStar({
    Key key,
    @required this.rating,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SmoothStarRating(
      rating: rating,
      size: 20,
      isReadOnly: true,
      filledIconData: Icons.star,
      color: Colors.yellow[700],
      halfFilledIconData: Icons.star_half,
      borderColor: Colors.yellow[900],
      defaultIconData: Icons.star_border,
      starCount: 5,
      allowHalfRating: true,
      spacing: 2.0,
    );
  }
}

///////////////////////////////////////////////////////////
class DismissibleWidget<T> extends StatelessWidget {
  final T item;
  final Widget child;
  final DismissDirectionCallback onDismissed;

  const DismissibleWidget({
    @required this.item,
    @required this.child,
    @required this.onDismissed,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Dismissible(
        key: UniqueKey(),
        background: buildSwipeActionRight(),
        child: child,
        onDismissed: onDismissed,
      );
  Widget buildSwipeActionRight() => Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: Icon(Icons.delete_forever, color: Colors.white, size: 32),
      );
}

/////////////////////////////////////////////////////////////
InkWell customSocialMdiaBottom({Function onTap, IconData icon, Color color}) {
  return InkWell(
    onTap: onTap,
    child: Icon(
      icon,
      color: color,
      size: 35,
    ),
  );
}

//////////////////////////////////////////////////////////////////////
flitter({BuildContext context, Widget child}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => child,
    isDismissible: true,
    enableDrag: true,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    // isScrollControlled: true,
  );
}

/////////////////////////////////////////////////////////////
Future<void> launchInBrowser(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  } else {
    throw 'Could not launch $url';
  }
}

// ------------------------------------------------------------------------
/////////////////////////////////////////////////////////////
Future<void> share({String url, String title}) async {
  await FlutterShare.share(
    title: title,
    linkUrl: url,
  );
}

// ------------------------------------------------------------------------
