import 'package:flutter/material.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class BtnCustom extends StatelessWidget {

  final String text;
  final double width;
  final double height;
  final double border;
  final Color colorText;
  final Color backgroundColor;
  final double fontSize;
  final FontWeight fontWeight;
  final bool isTitle;
  final Function()? onTap;

  const BtnCustom({
    Key? key,
    required this.text,
    required this.width,
    this.onTap,
    this.height = 50,
    this.border = 8.0,
    this.colorText = Colors.white,
    this.fontSize = 16,
    this.backgroundColor = ColorsFrave.primary,
    this.fontWeight = FontWeight.normal,
    this.isTitle = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(border))
        ),
        onPressed: onTap, 
        child: TextCustom(
          text: text, 
          isTitle: isTitle,
          color: colorText, 
          fontSize: fontSize, 
          fontWeight: fontWeight
        ),
      ),
    );
  }
}