import 'package:flutter/material.dart';
import 'package:safe_manager/presentation/components/components.dart';

class CardHomeHeader extends StatelessWidget {

  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Function() onTap;

  const CardHomeHeader({
    Key? key, 
    required this.title, 
    required this.subtitle, 
    required this.icon, 
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 130,
        width: 110,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: color.withOpacity(.1),
          borderRadius: BorderRadius.circular(12.0)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Theme.of(context).cardColor,
              child: Icon(icon, color: color),
            ),
            const SizedBox(height: 10.0),
            TextCustom(
              text: title,
              isTitle: true,
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(height: 5.0),
            TextCustom(
              text: subtitle,
              color: const Color(0xff7e8896),
              fontSize: 12,
            ),
          ],
        ),
      ),
    );
  }
}