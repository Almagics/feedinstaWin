import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';
import '../resources/routes_manager.dart';
import '../resources/theme_manager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../l10n/l10n.dart';

class MyApp extends StatefulWidget {
   MyApp({super.key, required this.locale});
int appstat = 0;
 final Locale? locale;

//MyApp._internal({this.locale});

//static final MyApp _instance = MyApp._internal();

//factory MyApp({Locale? locale}) {
  //_instance.locale = locale;
 // return _instance;
//}

@override
State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [const Locale('en', ''), const Locale('ar', '')],
      locale: widget.locale,


      onGenerateRoute: RouteGenerator.getRoute,
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.loginRoute,
      theme: getApplicationTheme(),);
  }
}