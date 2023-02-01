import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/card/components/modal_type_card.dart';
import 'package:safe_manager/presentation/screens/card/components/modal_type_card_option.dart';

class CardOptions extends StatelessWidget {

  const CardOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: const Color(0xffF3F1ED)
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              modalTypeCard(context);
            },
            child: BlocBuilder<CardBloc, CardState>(
              builder: (_, state) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width * .45,
                  child: TextCustom(
                    text: state.typeCard,
                    isTitle: true,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  ),
                );
              },
            ),
          ),
          Container(
            height: 25,
            width: 2,
            color: Colors.grey.shade300,
          ),
          GestureDetector(
            onTap: () {
              modalTypeCardOption(context);
            },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .45,
              child: BlocBuilder<CardBloc, CardState>(
                builder: (_, state) {
                  return TextCustom(
                    text: state.typeCardModel.name,
                    isTitle: true,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.w500,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}