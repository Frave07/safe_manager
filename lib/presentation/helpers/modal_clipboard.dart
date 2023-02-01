import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/presentation/components/components.dart';

void modalClipBoard(BuildContext context, String message){

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.green.shade50
            ),
            child: Row(
              children: [
                const SizedBox(width: 5),
                const Icon(FontAwesomeIcons.check, color: Colors.green, size: 18),
                const SizedBox(width: 15),
                Expanded(
                  child: TextCustom(
                    text: message, 
                    color: Colors.green, 
                    fontSize: 15,
                    isTitle: true,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          ),
        ],
      ), 
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    )
  );
}
