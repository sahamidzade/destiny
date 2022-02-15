import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/shared/util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class SettingsShared<T extends SettingsState> extends State<T> {
  String path = '';
  SharedPreferences? prefs;

  void initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      path = prefs?.getString(PATH) ?? '';
    });
  }

  void handleSelectFile() async {
    await canWriteToFile().then((permissionStatus) async {
      if (permissionStatus == PermissionStatus.granted) {
        String? result = await FilePicker.platform.getDirectoryPath();
        if (result == null) {
          return;
        }
        setState(() {
          path = result;
          prefs?.setString(PATH, result);
        });
      }
    });
  }

  Widget build(BuildContext context);
}

abstract class SettingsState extends StatefulWidget {
  SettingsState({Key? key}) : super(key: key);
}