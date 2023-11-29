// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:checkmate/constants/fonts.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.style,
    required this.text,
  }) : super(key: key);
  final TextStyle? style;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ??
          TextStyle(color: Colors.black, fontSize: 20.sp, fontFamily: fExo),
    );
  }
}
