import 'package:elgawda/secreens/splashscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:elgawda/routes.dart';
import 'constants/constans.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // const MyApp({Key key}) : super(key: key);
  // static void setLocale(BuildContext context, Locale newLocale) {
  //   _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
  //   state.setLocale(newLocale);
  // }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Locale _locale;
  // setLocale(Locale locale) async {
  //   setState(() {
  //     _locale = locale;
  //     // DBHelper.saveAppLang(locale.toString());
  //   });
  //   print('Applan:' + locale.toString());
  // }

  // @override
  // void didChangeDependencies() {
  //   getLocale().then((locale) {
  //     setState(() {
  //       this._locale = locale;
  //     });
  //   });
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryIconTheme: IconThemeData(color: Colors.white),
        primaryColor: Colors.white,
        bottomAppBarColor: customColor,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: customColor),
          actionsIconTheme: IconThemeData(color: customColor),
        ),
        accentColor: customColor,
        iconTheme: IconThemeData(color: customColor),
      ),
      initialRoute: SplashScreen.route,
      routes: routes,
    );

    //  StreamProvider<User>.value(
    //     value: AuthServices().user,
    //     child: MaterialApp(
    //       debugShowCheckedModeBanner: false,
    //       theme: ThemeData(
    //         scaffoldBackgroundColor: Colors.white,
    //         // canvasColor: Colors.transparent,
    //       ),
    //       localizationsDelegates: [
    //         DemoLocalization.delegate,
    //         GlobalCupertinoLocalizations.delegate,
    //         GlobalMaterialLocalizations.delegate,
    //         GlobalWidgetsLocalizations.delegate,
    //       ],
    //       supportedLocales: [
    //         Locale('ar', 'EG'),
    //         Locale('en', 'US'),
    //       ],
    //       locale: _locale,
    //       localeResolutionCallback: (locale, supportedLocales) {
    //         for (var supportedLocale in supportedLocales) {
    //           if (supportedLocale.languageCode == locale.languageCode &&
    //               supportedLocale.countryCode == locale.countryCode) {
    //             return supportedLocale;
    //           }
    //         }
    //         return supportedLocales.first;
    //       },
    //       home: SplashScreen(),
    //     ));
  }
}
