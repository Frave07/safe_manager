import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/animation_route.dart';
import 'package:safe_manager/presentation/components/text_custom.dart';
import 'package:safe_manager/presentation/screens/about/home_about_screen.dart';
import 'package:safe_manager/presentation/screens/auth/login_screen.dart';
import 'package:safe_manager/presentation/screens/create/create_account_screen.dart';
import 'package:safe_manager/presentation/screens/delete/verify_password_delete_screen.dart';
import 'package:safe_manager/presentation/screens/initial/components/background_initial.dart';
import 'package:safe_manager/presentation/screens/passwords/generate_password_screen.dart';
import 'package:safe_manager/presentation/screens/report_problem/report_problem_screen.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

import 'components/item_menu.dart';


class InitialScreen extends StatelessWidget {

  const InitialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final randomNumberBloc = BlocProvider.of<RandomNumberBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);
     DateTime now = DateTime.now();

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundInitial(),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 60.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextCustom(
                          text: now.hour >= 20 
                            ? 'Good Night' 
                            : 'Good Day', 
                          isTitle: true, 
                          fontSize: 22, 
                          fontWeight: FontWeight.w600, 
                          color:now.hour >= 20 ? Colors.white : Colors.black
                        ),
                        Icon(FontAwesomeIcons.solidMoon, color: now.hour >= 20 ? Colors.white : Colors.amber )
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (_, state) {
                        return Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: ColorsFrave.primary.withOpacity(.9)
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 17,
                                child: Icon(state.existAccount ? FontAwesomeIcons.user : FontAwesomeIcons.solidFaceSadTear, size: 13),
                              ),
                              const SizedBox(width: 10.0),
                              TextCustom(
                                text: state.existAccount ? 'Main Account' : 'No account', 
                                isTitle: true,
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: [
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ItemMenu(
                                icon: FontAwesomeIcons.circlePlus,
                                title: 'Create',
                                isDisable: state.existAccount,
                                onTap: (){
                                  if(!state.existAccount){
                                    randomNumberBloc.add(GenerateRandomNumberCreateEvent());
                                    Navigator.push(context, routeFade(page: const CreateAccountScreen()));
                                  }
                                },
                              ),
                              ItemMenu(
                                icon: FontAwesomeIcons.rightToBracket,
                                title: 'Log In',
                                isDisable: !state.existAccount,
                                onTap: () async {
                                  if(state.existAccount){
                                    randomNumberBloc.add(GenerateRandomNumberCreateEvent());
                                    Navigator.push(context, routeFade(page: const LoginScreen())).then((_) {
                                      authBloc.add(ClearAllNumbersEvent());
                                    });
                                  }
                                },
                              ),
                              ItemMenu(
                                icon: FontAwesomeIcons.lock,
                                title: 'Delete',
                                isDisable: !state.existAccount,
                                onTap: (){
                                  if(state.existAccount){
                                    randomNumberBloc.add(GenerateRandomNumberCreateEvent());
                                    Navigator.push(context, routeFade(page: const VerifyPasswordDeleteScreen())).then((_){
                                      authBloc.add(ClearAllNumbersEvent());
                                    });
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ItemMenu(
                            icon: FontAwesomeIcons.bug,
                            title: 'Bug',
                            onTap: (){
                              Navigator.push(context, routeFade(page: const ReportProblemScreen()));
                            },
                          ),
                          ItemMenu(
                            icon: FontAwesomeIcons.circleInfo,
                            title: 'about',
                            onTap: (){
                              Navigator.push(context, routeFade(page: const HomeAboutScreen()));
                            },
                          ),
                          ItemMenu(
                            icon: FontAwesomeIcons.key,
                            title: 'Generate',
                            onTap: (){
                              Navigator.push(context, routeFade(page: const GeneratePasswordScreen()));
                            },
                          ),
                        ],
                      ),
                      
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}




