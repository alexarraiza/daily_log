import 'package:flutter/material.dart';

buildOurAppBar(
  Widget title, {
  List<Widget>? actions,
  Widget? leading,
}) {
  return AppBar(
    brightness: Brightness.dark,
    elevation: 0,
    centerTitle: true,
    title: title,
    actions: actions,
    leading: leading,
  );
}
