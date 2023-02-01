import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_manager/presentation/components/components.dart';

class ItemOptionType extends StatelessWidget {

  final Function() onTap;
  final Widget? icon;
  final String title;
  final String? svg;
  final bool isIcon;

  const ItemOptionType({
    Key? key, 
    required this.onTap,
    this.icon,
    required this.title,
    this.isIcon = true,
    this.svg
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      color: Theme.of(context).cardTheme.color,
      child: TextButton(
        onPressed: onTap, 
        style: TextButton.styleFrom(
          padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
          foregroundColor: Colors.grey
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                height: 30,
                width: isIcon ? 30 : 35,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: isIcon ? Colors.grey : Colors.white)
                ),
                child: isIcon
                ? icon
                : SvgPicture.asset('$svg', fit: BoxFit.contain)
              ),
              const SizedBox(width: 10.0),
              TextCustom(
                text: title, 
                isTitle: true,
                color: Theme.of(context).primaryColor,
              ),
            ],
          )
        )
      ),
    );
  }
}