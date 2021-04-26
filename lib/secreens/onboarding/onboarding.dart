import 'package:elgawda/constants/constans.dart';
import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/localization/localization_constants.dart';
import 'package:elgawda/secreens/authenticate/authenticate.dart';
import 'package:elgawda/secreens/onboarding/slider.dart';
import 'package:flutter/material.dart';

class OnBoard extends StatefulWidget {
  @override
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (User.userLogIn == true) {
    //   return Authenticate();
    // } else {
    return OnBoarding();
    // }
  }
}

class OnBoarding extends StatefulWidget {
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int _currentPage = 0;
  PageController _controller = PageController();
  List<Widget> _pages = [
    CustomSlider(
      title: 'Take Video Courses',
      contant: 'Take Video Courses',
      image: 'lib/images/img3.jpg',
      backImage: 'lib/images/back2.jpg',
    ),
    CustomSlider(
      title: 'Take Video Courses',
      contant: 'Take Video Courses',
      image: 'lib/images/img1.jpg',
      backImage: 'lib/images/back3.jpg',
    ),
    CustomSlider(
      title: 'Take Video Courses',
      contant:
          'Title Contant Title Contant Title Contant Title ContantTitle Contant Title Contant Title Contant Title Contant Title Contant Title Contant',
      image: 'lib/images/img2.jpg',
      backImage: 'lib/images/back2.jpg',
    ),
  ];
  _onChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemCount: _pages.length,
              onPageChanged: _onChanged,
              itemBuilder: (context, int index) {
                return _pages[index];
              },
            ),
          ),
          SliderContoler(
            pages: _pages,
            currentPage: _currentPage,
          ),
        ],
      ),
    );
  }
}

class SliderContoler extends StatelessWidget {
  const SliderContoler({
    Key key,
    @required List<Widget> pages,
    @required int currentPage,
  })  : _pages = pages,
        _currentPage = currentPage,
        super(key: key);

  final List<Widget> _pages;
  final int _currentPage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List<Widget>.generate(
            _pages.length,
            (int index) {
              return AnimatedContainer(
                duration: Duration(milliseconds: 300),
                height: 10,
                width: (index == _currentPage) ? 30 : 10,
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: (index == _currentPage)
                      ? customColorGold
                      : customColorGold.withOpacity(0.5),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            //  (_currentPage == (_pages.length - 1))
            //     ? MainAxisAlignment.center
            //     : MainAxisAlignment.spaceBetween,
            children: [
              // InkWell(
              //   onTap: () {
              //     if (_currentPage == (_pages.length - 1)) {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(
              //           builder: (_) => Authenticate(),
              //         ),
              //       );
              //     } else {
              //       _controller.nextPage(
              //         duration: Duration(milliseconds: 600),
              //         curve: Curves.easeInOutQuint,
              //       );
              //     }
              //   },
              //   child: AnimatedContainer(
              //     duration: Duration(milliseconds: 300),
              //     height: 40,
              //     width: 100,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(5),
              //       color: customColor,
              //     ),
              //     child: (_currentPage == (_pages.length - 1))
              //         ? Center(
              //             child: Text(
              //               'start',
              //               style: AppTheme.heading
              //                   .copyWith(color: Colors.white),
              //             ),
              //           )
              //         : Center(
              //             child: Text(
              //               'next',
              //               style: AppTheme.heading
              //                   .copyWith(color: Colors.white),
              //             ),
              //           ),
              //   ),
              // ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => Authenticate(),
                    ),
                    (routes) => false,
                  );
                },
                child: Container(
                  height: 35,
                  width: 86,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: customColorGold,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (_currentPage == (_pages.length - 1))
                            ? getTranslated(context, 'start')
                            : getTranslated(context, 'skip'),
                        style: AppTheme.heading.copyWith(color: Colors.white),
                      ),
                      (_currentPage == (_pages.length - 1))
                          ? Container()
                          : Transform.rotate(
                              angle: 180 * 3.14 / 180,
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
