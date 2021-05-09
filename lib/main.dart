import 'package:elgawda/constants/themes.dart';
import 'package:elgawda/routes.dart';
import 'package:elgawda/secreens/splashscreen.dart';
import 'package:elgawda/services/connectivity_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'constants/constans.dart';
import 'enums/connectivity_status.dart';
import 'localization/app_localization.dart';
import 'localization/localization_constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) async {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<ConnectivityStatus>(
      builder: (context) => ConnectivityService().connectionStatusController,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryIconTheme: IconThemeData(color: Colors.white),
          primaryColor: Colors.white,
          bottomAppBarColor: customColor,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 3,
            iconTheme: IconThemeData(color: customColor),
            actionsIconTheme: IconThemeData(color: customColor),
            centerTitle: true,
            textTheme: TextTheme(
              headline6: AppTheme.subHeadingColorBlue.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          accentColor: customColor,
          iconTheme: IconThemeData(color: customColor),
        ),
        supportedLocales: [
          const Locale('en', 'US'),
          const Locale('ar', 'EG'),
        ],
        locale: _locale,
        localizationsDelegates: [
          AppLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales) {
          for (var locale in supportedLocales) {
            if (locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode) {
              return deviceLocale;
            }
          }

          return supportedLocales.first;
        },
        initialRoute: SplashScreen.route,
        routes: routes,
      ),
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
