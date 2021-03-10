import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadingWidget(context, label, color) {
  var size = MediaQuery.of(context).size;
  return Center(
    child: Container(
        height: size.height * 1,
        width: size.width,
        color: color,
        child: Theme(
            data: ThemeData(
                cupertinoOverrideTheme:
                    CupertinoThemeData(brightness: Brightness.dark)),
            child: CupertinoActivityIndicator(
              radius: size.height * 0.05,
            ))),
  );
}
