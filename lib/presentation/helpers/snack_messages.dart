import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/presentation/components/components.dart';

void snackMessage(BuildContext context, String message){

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 65,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.grey.shade50
            ),
            child: Row(
              children: [
                const SizedBox(width: 15),
                Expanded(
                  child: TextCustom(
                    text: message, 
                    fontSize: 15,
                    maxLines: 3,
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
      behavior: SnackBarBehavior.floating,
      elevation: 0,
    )
  );
}


void snackMessageSuccess(BuildContext context, String message){

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 55,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.green.shade50
            ),
            child: Row(
              children: [
                Icon(FontAwesomeIcons.check, color: Colors.green.shade800, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: TextCustom(
                    text: message, 
                    fontSize: 15,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                    color: Colors.green.shade800,
                  ),
                ),
              ],
            )
          ),
        ],
      ), 
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: const Duration(seconds: 2),
    )
  );
}