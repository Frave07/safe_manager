import 'package:flutter/material.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class CardItemSecurity extends StatelessWidget {

  final String title;
  final Function()? onTap;
  final IconData icon;
  final Widget prefixWidget;

  const CardItemSecurity({
    Key? key, 
    required this.title,
    required this.icon,
    this.onTap,
    required this.prefixWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: ColorsFrave.primary.withOpacity(.6)),
                const SizedBox(width: 15.0),
                TextCustom(
                  text: title,
                  isTitle: true,
                ),
              ],
            ),
            prefixWidget
          ],
        ),
      ),
    );
  }
}