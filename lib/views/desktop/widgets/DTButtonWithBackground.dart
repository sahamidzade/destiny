import 'package:dart_wormhole_gui/config/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DTButtonWithBackground extends StatelessWidget {
  String title = '';
  Function handleSelectFile = () {};
  Widget? icon;
  DTButtonWithBackground({
    String title = '',
    required Function handleSelectFile,
    Widget? icon,
  }) {
    this.title = title;
    this.icon = icon;
    this.handleSelectFile = handleSelectFile;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
        border: Border(
          top: BorderSide(width: 1.0, color: CustomColors.purple),
          left: BorderSide(width: 1.0, color: CustomColors.purple),
          right: BorderSide(width: 1.0, color: CustomColors.purple),
          bottom: BorderSide(width: 1.0, color: CustomColors.purple),
        ),
      ),
      width: 100.0.w,
      height: 30.0.h,
      child:  FlatButton(
        onPressed: () => handleSelectFile(),
        color: Theme.of(context).primaryColor,
        child:Text('${title}',
            style: Theme.of(context).textTheme.subtitle1
        ),
      ),
    );
  }
}
