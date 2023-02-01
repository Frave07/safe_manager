import 'package:flutter/material.dart';
import 'package:safe_manager/presentation/components/text_custom.dart';

class ItemMenu extends StatelessWidget {

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDisable;

  const ItemMenu({
    Key? key, 
    required this.icon, 
    required this.title,
    required this.onTap,
    this.isDisable = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      borderRadius: BorderRadius.circular(50.0),
      splashColor: Colors.white,
      highlightColor: Colors.white,
      onTap: isDisable ? null : onTap,
      child: Container(
        alignment: Alignment.center,
        height: 75,
        width: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: isDisable ? Colors.grey :Colors.white, size: 18),
            const SizedBox(height: 10.0),
            TextCustom(
              text: title, 
              color: isDisable ? Colors.grey :Colors.white, 
              fontSize: 14,
              maxLines: 3, 
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );

  }
}