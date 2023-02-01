import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';

void modalChooseCategoryPassword(BuildContext context) {

  final passwordBloc = BlocProvider.of<PasswordBloc>(context);

  showModalBottomSheet(
    context: context, 
    barrierColor: Colors.black54,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    builder: (context) => Container(
      height: 170,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
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
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                 
                  GestureDetector(
                    onTap: () {
                      passwordBloc.add(const SelectTypePasswordEvent(1));
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Row(
                        children: const [
                          Icon(FontAwesomeIcons.earthAmericas, color: Color(0xffB288F7)),
                          SizedBox(width: 10.0),
                          TextCustom(
                            text: 'Browser',
                            isTitle: true,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const Divider(height: 1),
                  const SizedBox(height: 5.0),
                  GestureDetector(
                    onTap: () {
                      passwordBloc.add(const SelectTypePasswordEvent(2));
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: Row(
                        children: const [
                          Icon(FontAwesomeIcons.mobileScreen, color: Color(0xff2D9E2D)),
                          SizedBox(width: 10.0),
                          TextCustom(
                            text: 'App',
                            isTitle: true,
                          )
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );


}