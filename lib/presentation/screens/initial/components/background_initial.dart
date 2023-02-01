import 'package:flutter/material.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class BackgroundInitial extends StatelessWidget {

  const BackgroundInitial({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    DateTime now = DateTime.now();

    return Container(
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [
            .15,
            .45,
            .6,
            1,
          ],
          colors: [
            now.hour >= 20 
              ? const Color.fromARGB(255, 5, 25, 51)
              : Colors.white,
            ColorsFrave.primary.withOpacity(.8),
            ColorsFrave.primary,
            ColorsFrave.primary,
          ] 
        )
      ),
    );
  }
}