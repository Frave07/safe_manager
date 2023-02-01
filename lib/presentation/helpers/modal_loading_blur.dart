import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

void modalLoadingblur(BuildContext context, {Color color = Colors.white}){

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black45, 
    builder: (context) 
      => BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 3.0,
          sigmaY: 3.0,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          color: color.withOpacity(0.3),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0)
              ),
              child: const CircularProgressIndicator(color: ColorsFrave.primary)
            ),
          )
        ),
      ),
  );

}