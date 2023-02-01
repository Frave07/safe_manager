import 'package:flutter/material.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class AnimatedToggle extends StatefulWidget {

  final bool isActive;
  final Color colorInactive;

  const AnimatedToggle({
    Key? key,
    required this.isActive,
    this.colorInactive = Colors.grey
  }) : super(key: key);

  @override
  AnimatedToggleState createState() => AnimatedToggleState();
}

class AnimatedToggleState extends State<AnimatedToggle> {

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: 55,
      height: width * .07,
      child: Stack(
        children: [

          Container(
            width: width,
            height: width * .14,
            decoration: ShapeDecoration(
              color: widget.isActive ? ColorsFrave.primary : widget.colorInactive,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * .1))
            ),
          ),

          AnimatedAlign(
              alignment: widget.isActive ? Alignment.centerRight : Alignment.centerLeft, 
              duration: const Duration(milliseconds: 350),
              curve: Curves.ease,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.0),
                child: Icon(Icons.circle, size: 25, color: Colors.white),
              ),
            ),

        ],
      ),
    );
  }
}