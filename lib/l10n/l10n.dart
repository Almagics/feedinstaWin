import 'package:flutter/material.dart';
import 'app_localizations.dart';

String getTranslated(BuildContext context, String key) {
  return AppLocalizations.of(context)!.translate(key);
}
