import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'l10n/app_localizations.dart';
import 'model/context/dbcontext.dart';
import 'model/context/fillDatabase.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  Locale locale = await AppLocalizations.getLocale() ?? Locale('en', '');









  runApp( MyApp(locale: locale,));
}

