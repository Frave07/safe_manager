import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';

class DesignCard extends StatelessWidget {

  const DesignCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<CardBloc, CardState>(
      builder: (_, state) {
        return  Container(
          height: 210,
          width: double.infinity,
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Color(state.typeCardColor.color)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              BlocBuilder<CardBloc, CardState>(
                builder: (_, state) {
                  return TextCustom(
                    text: state.typeCard,
                    isTitle: true,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  );
                },
              ),
              const SizedBox(height: 35.0),
              TextCustom(
                text: state.cardNumber,
                isTitle: true,
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: Colors.white,
              ),
              const SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextCustom(
                            text: 'VALID THRU',
                            isTitle: true,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 5.0),
                          TextCustom(
                            text: state.cardDate,
                            isTitle: true,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      const SizedBox(width: 20.0),
                      Column(
                        children: [
                          const TextCustom(
                            text: 'CVV',
                            isTitle: true,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          const SizedBox(height: 5.0),
                          TextCustom(
                            text: state.cardCvv,
                            isTitle: true,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  BlocBuilder<CardBloc, CardState>(
                    builder: (_, state) {
                      return SvgPicture.asset(state.typeCardModel.icon,
                        height: state.typeCardModel.uid == 5 || state.typeCardModel.uid == 4 || state.typeCardModel.uid == 3 ? 51 : 30
                      );
                    },
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}