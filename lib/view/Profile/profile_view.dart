import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';


import '../../app/app.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/l10n.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'chanagelang')),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: ColorManager.white,),
          onPressed: () {
            Navigator.pushReplacementNamed(context, Routes.mainRoute);// Navigate back to the previous screen
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Center(
              child: const Text('English',

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),


              ),
            ),
            onTap: () {
              _changeLanguage('en');
            },
          ),
          ListTile(
            title: Center(
              child: const Text('العربية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

              ),
            ),
            onTap: ()
            {

                _changeLanguage( 'ar');


            },
          ),
          // Add more languages as needed
        ],
      ),
    );
  }



  Future<void> _changeLanguage(String languageCode) async {
    Locale newLocale = Locale(languageCode, '');
    AppLocalizations.setLocale(newLocale);
    Restart.restartApp();
  }
}
