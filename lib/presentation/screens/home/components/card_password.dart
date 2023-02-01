import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/domain/models/password_model.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/helpers/snack_messages.dart';
import 'package:safe_manager/presentation/screens/home/view_password_screen.dart';
import 'package:timeago/timeago.dart' as timeago;

class CardPassword extends StatelessWidget {

  final PasswordModel password;
  final int index;

  const CardPassword({Key? key, required this.password, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final passwordBloc = BlocProvider.of<PasswordBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, routeFade(page: ViewPasswordScreen(password: password, index: index)));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Theme.of(context).cardTheme.color,
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.blueGrey.shade50
                      ),
                      child: SvgPicture.asset(password.pathLogo, height: 30),
                    ),
                    const SizedBox(width: 15.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextCustom(
                          text: password.nickname,
                          fontWeight: FontWeight.w600,
                          isTitle: true,
                          color: Theme.of(context).primaryColor,
                        ),
                        TextCustom(
                          text: timeago.format(password.date),
                          color: const Color(0xff7e8896),
                          fontSize: 12,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: (){
                  snackMessageSuccess(context, 'copied');
                  passwordBloc.add(CopyPasswordEvent(password));
                }, 
                icon: Icon(FontAwesomeIcons.clone, size: 20, color: Colors.grey.shade600)
              )
            ],
          ),
        ),
      ),
    );
  }
}