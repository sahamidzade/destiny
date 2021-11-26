import 'dart:ffi';

import 'package:dart_wormhole_gui/views/desktop/widgets/DTButton.dart';
import 'package:dart_wormhole_gui/views/desktop/widgets/DTFileInfo.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/FileInfo.dart';
import 'package:dart_wormhole_gui/views/widgets/Heading.dart';
import 'package:dart_wormhole_gui/views/mobile/widgets/buttons/Button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dart_wormhole_gui/constants/app_constants.dart';
import 'DTRowGroupButton.dart';

class DTCodeGeneration extends StatelessWidget {
  String? fileName = '';
  int? fileSize = 0;
  String code = '';
  bool? isCodeGenerating = false;
  DTCodeGeneration({
    Key? key,
    String? fileName,
    int? fileSize,
    String code = '',
    bool? isCodeGenerating
  }):super(key:key) {
    this.fileName = fileName;
    this.fileSize = fileSize;
    this.code = code;
    this.isCodeGenerating = isCodeGenerating;
  }
  @override
  Widget build(BuildContext context) {
      return  Container (
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
                Container (
                  padding: EdgeInsets.only(right: 40.0.w),
                  child:  Heading(
                    title: SEND_THE_SELECTED_CODE_BY_SHARING_THE_CODE_WITH_RECIPIENT,
                    textStyle: Theme.of(context).textTheme.headline1,
                  ),
                ),
                DTFileInfo(fileSize, fileName),
                DTRowGroupButton(code, isCodeGenerating!),
                isCodeGenerating! ?
                SizedBox(
                  width: 200.0.w,
                  child: Heading(
                    title: SHARE_CODE_WITH_RECIPIENT_AND_WAIT_UNTIL_THE_TRANSFER_IS_COMPLETE,
                    textAlign:TextAlign.center,
                    marginTop: 16.0.h,
                    textStyle: Theme.of(context).textTheme.subtitle1,
                    key:Key(GENERATION_DESCRIPTION),
                  ),
                ):
                Heading(
                  title: THE_TRANSFER_WILL_AUTO,
                  textAlign:TextAlign.center,
                  marginTop: 16.0.h,
                  textStyle: Theme.of(context).textTheme.subtitle1,
                  key:Key(GENERATION_DESCRIPTION),
                ),
                Column(
                  children: [
                    isCodeGenerating! ?
                    DTButton(
                      CANCEL,
                          () {},
                    )
                        :
                    DTButton(
                      CANCEL,
                          () {},
                    ),
                    SizedBox(
                      height: 37.0.h,
                    )
                  ],
                )
              ],
            ),
      );
  }
}