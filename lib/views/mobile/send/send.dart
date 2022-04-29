import 'package:dart_wormhole_gui/config/routes/routes.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/CodeGeneration.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SelectAFileUI.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SendingDone.dart';
import 'package:dart_wormhole_gui/views/mobile/send/widgets/SendingProgress.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-app-bar.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/custom-bottom-bar.dart';
import 'package:dart_wormhole_gui/views/shared/send.dart';
import 'package:dart_wormhole_william/client/native_client.dart';
import 'package:flutter/material.dart';
import '../../widgets/Heading.dart';
import '../widgets/ErrorUI.dart';

class Send extends SendState {
  Send(config, {Key? key}) : super(config, key: key);

  @override
  SendScreen createState() => SendScreen(config);
}

class SendScreen extends SendShared<Send> {
  SendScreen(Config config) : super(config);

  Widget generateCodeUI() {
    return CodeGeneration(
      fileName,
      fileSize,
      code,
      currentState == SendScreenStates.CodeGenerating,
      cancelSend,
      key: Key(SEND_SCREEN_CODE_GENERATION_UI),
    );
  }

  Widget selectAFileUI() {
    return SelectAFileUI(handleSelectFile);
  }

  Widget sendingProgress() {
    return SendingProgress(
        fileSize,
        fileName,
        progress.percentage,
        progress.remainingTimeString ??
            (progress.percentage - 1.0 <= 0.001
                ? WAITING_FOR_RECEIVER
                : THREE_DOTS),
        this.cancelFunc);
  }

  Widget sendingDone() {
    return SendingDone(fileSize, fileName);
  }

  Widget sendingError() {
    return Column(
      children: [
        Heading(title: errorMessage ?? "Unknown error"),
      ],
    );
  }

  Widget transferCancelled() {
    return ErrorUI(
        text: THE_TRANSFER_HAS_BEEN_INTERRUPTED,
        subText: 'Send a file',
        route: SEND_ROUTE);
  }

  Widget transferRejected() {
    return ErrorUI(
        text: "$THE_TRANSFER_HAS_BEEN_CANCELLED \nthe receiver.",
        subText: 'Send a file',
        route: SEND_ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CustomBottomBar(
          path: SEND_ROUTE,
          key: Key(BOTTOM_NAV_BAR),
        ),
        appBar: CustomAppBar(
          title: SEND,
          key: Key(CUSTOM_NAV_BAR),
        ),
        body: WillPopScope(
            onWillPop: () async => false,
            child: Container(
                width: double.infinity,
                key: Key(SEND_SCREEN_BODY),
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                    child: widgetByState(
                        generateCodeUI,
                        selectAFileUI,
                        sendingError,
                        sendingDone,
                        sendingProgress,
                        transferCancelled,
                        transferRejected)))));
  }
}
