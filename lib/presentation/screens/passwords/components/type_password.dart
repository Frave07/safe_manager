import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/passwords/components/modal_choose_category_password.dart';

class TypePassword extends StatelessWidget {

  const TypePassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        modalChooseCategoryPassword(context);
      },
      child: BlocBuilder<PasswordBloc, PasswordState>(
        builder: (_, state) {
          return Container(
            width: 140,
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: state.typePassword == 1
              ? const Color(0xffB288F7).withOpacity(.1)
              : state.typePassword == 2
                ? const Color(0xff2D9E2D).withOpacity(.1)
                : Colors.red.shade50,
              border: Border.all(
                color: state.typePassword == 1
                ? const Color(0xffB288F7)
                : state.typePassword == 2
                  ? const Color(0xff2D9E2D)
                  : Colors.red
              )
            ),
            child: Row(
              children: [
                Icon(
                  state.typePassword == 1
                  ? FontAwesomeIcons.earthAmericas
                  : state.typePassword == 2
                    ? FontAwesomeIcons.mobileScreen
                    : FontAwesomeIcons.plus, 
                  color: state.typePassword == 1
                    ? const Color(0xffB288F7)
                    : state.typePassword == 2
                      ? const Color(0xff2D9E2D)
                      : Colors.grey, 
                  size: 17
                ),
                const SizedBox(width: 8.0),
                TextCustom(
                  text: state.typePassword == 1 
                    ? 'Browser'
                    : state.typePassword == 2
                      ? 'App'
                      : 'Type',
                  isTitle: true,
                  color: Colors.blueGrey,
                  fontSize: 14,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}