import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:restart_app/restart_app.dart';
import 'package:share/share.dart';

import 'package:sqflite/sqflite.dart';


import '../../app/app.dart';
import '../../l10n/app_localizations.dart';
import '../../l10n/l10n.dart';
import '../../resources/color_manager.dart';
import '../../resources/routes_manager.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});




  Future<bool> storagePermission() async {
    final DeviceInfoPlugin info = DeviceInfoPlugin(); // import 'package:device_info_plus/device_info_plus.dart';
    final AndroidDeviceInfo androidInfo = await info.androidInfo;
    debugPrint('releaseVersion : ${androidInfo.version.release}');
    final int androidVersion = int.parse(androidInfo.version.release);
    bool havePermission = false;

    if (androidVersion >= 13) {
      final request = await [
        Permission.videos,
        Permission.photos,
        //..... as needed
      ].request(); //import 'package:permission_handler/permission_handler.dart';

      havePermission = request.values.every((status) => status == PermissionStatus.granted);
    } else {
      final status = await Permission.storage.request();
      havePermission = status.isGranted;
    }

    if (!havePermission) {
      // if no permission then open app-setting
      await openAppSettings();
    }

    return havePermission;
  }










  Future<void> backupDatabase() async {
    // Request storage permissions





    final directory = Directory('/storage/emulated/0/Download/fedak_backup');

    // Create the backup directory if it doesn't exist
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }





    try {
      // Get the application documents directory
     // final directory = await getApplicationDocumentsDirectory();

      // Construct the path to the database file
    //  final dbPath = join(directory.path, 'your_database.db');
      String dbPath = join(await getDatabasesPath(), 'feeddb.db');
      // Construct the path to the backup file
     final backupPath = join(directory.path, 'feeddb.db');


      // Request storage permissions







      // Copy the database file to the backup location
      final dbFile = File(dbPath);
      final backupFile = await dbFile.copy(backupPath);

      // Share the backup file (optional)
      await Share.shareFiles([backupFile.path], text: 'Here is your database backup.');

      print('Database backup created successfully: $backupPath');
    } catch (e) {
      print('Error during database backup: $e');
    }
  }



  Future<void> restoreDatabase(BuildContext  context) async {
    // Request storage permissions


    try {
      // Let the user pick the backup file
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if (result != null && result.files.isNotEmpty) {
        // Get the path of the picked file
        String backupFilePath = result.files.single.path!;

        // Get the application documents directory
        final directory = await getApplicationDocumentsDirectory();

        // Construct the path to the original database file
        final dbPath = join(await getDatabasesPath(), 'feeddb.db');
      //  String dbPath = join(await getDatabasesPath(), 'feeddb.db');
        // Replace the original database file with the backup file
        final backupFile = File(backupFilePath);
        final dbFile = File(dbPath);

        // Overwrite the existing database file with the backup
        await backupFile.copy(dbFile.path);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Restore Completed!')),
          //  _changeLanguage( 'ar');

        );

        print('Database restored successfully from: $backupFilePath');
      } else {
        print('No file selected for restore');
      }
    } catch (e) {
      print('Error during database restore: $e');
    }
  }








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

          ListTile(
            title: Center(
              child: const Text('Backup',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

              ),
            ),
            onTap: ()
            async {

              final permission = await storagePermission();
              debugPrint('permission : $permission');

              //await _requestPermission();
              await backupDatabase();
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Backup Completed!')),
            //  _changeLanguage( 'ar');

              );}

          ),

          ListTile(
            title: Center(
              child: const Text('Restore',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),

              ),
            ),
            onTap: ()
            async {
              final permission = await storagePermission();
              debugPrint('permission : $permission');
              //  _changeLanguage( 'ar');
              restoreDatabase(context);




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
