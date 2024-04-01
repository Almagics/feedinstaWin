import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';
import 'model/context/dbcontext.dart';
import 'model/context/fillDatabase.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  Locale locale = await AppLocalizations.getLocale() ?? Locale('en', '');




  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );




  runApp( MyApp(locale: locale,));
}

