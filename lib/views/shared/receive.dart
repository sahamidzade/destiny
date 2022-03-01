import 'dart:io';
import 'dart:math';

import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/shared/progress.dart';
import 'package:dart_wormhole_william/client/client.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_wormhole_gui/views/shared/util.dart';

enum ReceiveScreenStates {
  FileReceived,
  ReceiveError,
  FileReceiving,
  ReceiveConfirmation,
  Initial,
}

abstract class ReceiveShared<T extends ReceiveState> extends State<T> {
  String? _code;
  late int fileSize;
  late String fileName;

  ReceiveScreenStates currentState = ReceiveScreenStates.Initial;
  late final TextEditingController controller = new TextEditingController();
  SharedPreferences? prefs;
  final Config config;
  late final Client client = Client(config);
  String? get path => prefs?.getString(PATH);
  String? error;

  late void Function() acceptDownload;
  late void Function() rejectDownload;

  ReceiveShared(this.config) {
    SharedPreferences.getInstance().then((prefs) {
      this.prefs = prefs;
    });
  }

  late ProgressShared progress = ProgressShared(setState, () {
    currentState = ReceiveScreenStates.FileReceiving;
  });

  void codeChanged(String code) {
    setState(() {
      _code = code;
    });
  }

  static String _tempPath(String prefix) {
    final r = Random();
    int suffix = r.nextInt(1 << 32);
    while (File("$prefix.$suffix").existsSync()) {
      suffix = r.nextInt(1 << 32);
    }

    return "$prefix.$suffix";
  }

  Future<ReceiveFileResult> receive() async {
    String? _path = path;
    if (_path == null) {
      this.setState(() {
        prefs?.setString(
            PATH,
            Platform.isAndroid
                ? DOWNLOADS_FOLDER_PATH
                : Directory.current.path);
      });
      _path = path;
    }

    return canWriteToFile().then((permissionStatus) async {
      if (permissionStatus == PermissionStatus.granted) {
        late final File tempFile;

        return client.recvFile(_code!, progress.progressHandler).then((result) {
          result.done.then((value) {
            this.setState(() {
              currentState = ReceiveScreenStates.FileReceived;
            });
            return tempFile.rename("$_path/${result.pendingDownload.fileName}");
          }, onError: (error, stacktrace) {
            this.setState(() {
              currentState = ReceiveScreenStates.ReceiveError;
              error = error.toString();
            });
            return tempFile;
          });

          this.setState(() {
            currentState = ReceiveScreenStates.ReceiveConfirmation;
            acceptDownload = () {
              controller.text = '';
              tempFile =
                  File(_tempPath("$_path/${result.pendingDownload.fileName}"));
              result.pendingDownload.accept(tempFile);
              this.setState(() {
                currentState = ReceiveScreenStates.FileReceiving;
              });
            };
            rejectDownload = () {
              result.pendingDownload.reject();
              this.setState(() {
                currentState = ReceiveScreenStates.Initial;
              });
            };
            fileName = result.pendingDownload.fileName;
            fileSize = result.pendingDownload.size;
          });

          return result;
        });
      } else {
        return Future.error(Exception("Permission denied"));
      }
    });
  }

  Widget widgetByState(
      Widget Function() receivingDone,
      Widget Function() receiveError,
      Widget Function() receiveProgress,
      Widget Function() enterCodeUI,
      Widget Function() receiveConfirmation) {
    switch (currentState) {
      case ReceiveScreenStates.Initial:
        return enterCodeUI();
      case ReceiveScreenStates.ReceiveError:
        return receiveError();
      case ReceiveScreenStates.ReceiveConfirmation:
        return receiveConfirmation();
      case ReceiveScreenStates.FileReceived:
        return receivingDone();
      case ReceiveScreenStates.FileReceiving:
        return receiveProgress();
    }
  }

  Widget build(BuildContext context);
}

abstract class ReceiveState extends StatefulWidget {
  final Config config;

  ReceiveState(this.config, {Key? key}) : super(key: key);
}
