import 'package:flutter/material.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

void modalMessage(BuildContext context, String message){

  showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black12,
    builder: (context) 
      => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Row(
                  children: const [
                    Icon(Icons.info_rounded, color: Colors.black, size: 30),
                    SizedBox(width: 10.0),
                    TextCustom(text: 'Safe Manager', isTitle: true, fontWeight: FontWeight.w600)
                  ],
                ),
                const SizedBox(height: 20.0),
                TextCustom(text: message, fontSize: 17, fontWeight: FontWeight.w400, textAlign: TextAlign.left),
              ],
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: ColorsFrave.primary
              ),
              onPressed: () => Navigator.pop(context), 
              child: const TextCustom(text: 'Ok', color: ColorsFrave.primary, fontWeight: FontWeight.w500,)
            )
          ],
      ),
  );
}