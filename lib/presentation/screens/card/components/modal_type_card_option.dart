import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/data/type_card/type_card_model.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/screens/home/components/item_option_type.dart';

void modalTypeCardOption(BuildContext context) {

  final cardBloc = BlocProvider.of<CardBloc>(context);

  showModalBottomSheet(
    context: context, 
    barrierColor: Colors.black38,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    builder: (context) => Container(
      height: 550,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white70
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: TypeCardModel.typeCardModel.length,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      ItemOptionType(
                        isIcon: false,
                        svg: TypeCardModel.typeCardModel[i].icon,
                        onTap: () {
                          cardBloc.add(SelectTypeCardModelEvent(TypeCardModel.typeCardModel[i]));
                          Navigator.pop(context);
                        },
                        icon: const Icon(FontAwesomeIcons.creditCard, size: 17, color: Colors.green),
                        title: TypeCardModel.typeCardModel[i].name,
                      ),
                      const Divider(height: 5, color: Colors.white),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    ),
  ).then((_){
    cardBloc.add(ClearChangeTypeCardEvent());
  });


}