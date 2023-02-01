import 'package:flutter/material.dart';
import 'package:safe_manager/presentation/components/components.dart';

class NumberOption extends StatelessWidget {

  final String text;
  final Function() onTap;

  const NumberOption({
    Key? key, 
    required this.text, 
    required this.onTap
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(50.0),
        onTap: onTap,
        child: Ink(
          height: 65,
          width: 65,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            shape: BoxShape.circle
          ),
          child: Center(
            child: TextCustom(
              text: text,
              fontWeight: FontWeight.w600,
              fontSize: 19,
            ),
          ),
        ),
      ),
    );
  }
}