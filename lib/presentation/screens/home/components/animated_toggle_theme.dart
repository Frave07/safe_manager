import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';

class AnimatedToggleTheme extends StatelessWidget {

  final Function() onChanged;

  const AnimatedToggleTheme({
    Key? key, 
    required this.onChanged,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final listValues = ['ON', 'OFF'];

    return SizedBox(
      width: size.width,
      height: size.width * .11,
      child: Stack(
        children: [
          GestureDetector(
            onTap: onChanged,
            child: Container(
              width: size.width,
              height: size.width * .12,
              decoration: ShapeDecoration(
                color: Theme.of(context).cardTheme.color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size.width * .1))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(listValues.length, (i) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * .1),
                    child: TextCustom(text: listValues[i], fontSize: size.width * .05,),
                  )
                )
              ),
            ),
          ),

          BlocBuilder<ThemesBloc, ThemesState>(
            builder: (_, state) => AnimatedAlign(
              alignment: state.isOscure ? Alignment.centerLeft : Alignment.centerRight, 
              duration: const Duration(milliseconds: 350),
              curve: Curves.ease,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Container(
                  alignment: Alignment.center,
                  width: size.width * .38,
                  height: size.width * .09,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size.width * .1)),
                  ),
                  child: TextCustom(text: state.isOscure 
                    ? listValues[0]
                    : listValues[1],
                    fontSize: size.width * .05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}