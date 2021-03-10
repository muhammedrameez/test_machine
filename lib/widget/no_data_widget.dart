import 'package:flutter/material.dart';
import 'package:test_machine_app/util/color_theme.dart';
import 'package:test_machine_app/widget/loading_widget.dart';

Widget noDataWidget(context, size, text1, text2) {
  return FutureBuilder(
      future: Future.delayed(Duration(
        seconds: 5,
      )),
      builder: (c, s) => s.connectionState == ConnectionState.done
          ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Text(
                    text1,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: size.width * 0.04),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                    width: size.width * 0.6,
                    child: Text(
                      text2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  //HtmlWidget('Hello World!'),
                ],
              ),
            )
          : loadingWidget(context, "", ColorTheme.colorTheme1));
}
