import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/initial/initial_screen.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class VerifyPasswordDeleteScreen extends StatefulWidget {

  const VerifyPasswordDeleteScreen({Key? key}) : super(key: key);

  @override
  State<VerifyPasswordDeleteScreen> createState() => _VerifyPasswordDeleteScreenState();
}

class _VerifyPasswordDeleteScreenState extends State<VerifyPasswordDeleteScreen> {



  @override
  Widget build(BuildContext context) {

    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state.numbers.length == 6){
          Future.delayed(const Duration(milliseconds: 350)).then((_) {
            authBloc.add(VerifyAccountForDeleteEvent());
          });
        }
        if(state.isSuccessPassword){
          authBloc.add(ClearAllEvent());
          Navigator.pushAndRemoveUntil(context, routeFade(page: const InitialScreen()), (_) => false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              splashRadius: 20,
              onPressed: (){
                authBloc.add(ClearAllNumbersEvent());
                Navigator.pop(context);
              }, 
              icon: const Icon(FontAwesomeIcons.xmark, size: 20.0)
            )
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Center(
                  child: TextCustom(
                    text: 'Enter your password for delete account',
                    fontSize: 21,
                    isTitle: true,
                    textAlign: TextAlign.center,
                    color: ColorsFrave.primary,
                    fontWeight: FontWeight.w500,
                  )
                ),
                Column(
                  children: [
                    const SizedBox(height: 40.0),
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (_, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (i) => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                state.numbers.length >= i + 1
                                ? FontAwesomeIcons.solidCircle
                                : FontAwesomeIcons.circle, 
                                color: state.numbers.length >= i + 1
                                ? state.isFailPassword
                                  ? Colors.red
                                  : ColorsFrave.primary
                                : Colors.grey, 
                                size: 16.0
                              ),
                            )
                          ),
                        ); 
                      },
                    ),
                    const SizedBox(height: 24.0),
                    BlocBuilder<RandomNumberBloc, RandomNumberState>(
                      builder: (_, state) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NumberOption(
                                  text: '${state.listNumberByCreate[0]}',
                                  onTap: () {
                                    authBloc.add(SelectNumberEvent(state.listNumberByCreate[0]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[1]}',
                                  onTap: () {
                                    authBloc.add(SelectNumberEvent(state.listNumberByCreate[1]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[2]}',
                                  onTap: () {
                                    authBloc.add(SelectNumberEvent(state.listNumberByCreate[2]));
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NumberOption(
                                  text: '${state.listNumberByCreate[3]}',
                                  onTap: () {
                                    authBloc.add(SelectNumberEvent(state.listNumberByCreate[3]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[4]}',
                                  onTap: () {
                                    authBloc.add(SelectNumberEvent(state.listNumberByCreate[4]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[5]}',
                                  onTap: () {
                                    authBloc.add(SelectNumberEvent(state.listNumberByCreate[5]));
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                NumberOption(
                                  text: '${state.listNumberByCreate[6]}',
                                  onTap: () {
                                    authBloc.add(SelectNumberEvent(state.listNumberByCreate[6]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[7]}',
                                  onTap: () {
                                    authBloc.add(SelectNumberEvent(state.listNumberByCreate[7]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[8]}',
                                  onTap: () {
                                    authBloc.add(SelectNumberEvent(state.listNumberByCreate[8]));
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(width: 70.0,),
                                NumberOption(
                                  text: '${state.listNumberByCreate[9]}',
                                  onTap: () {
                                    authBloc.add(SelectNumberEvent(state.listNumberByCreate[9]));
                                  },
                                ),
                                const SizedBox(width: 20.0),
                                BlocBuilder<AuthBloc, AuthState>(
                                  builder: (_, stateAuth) => IconButton(
                                    splashRadius: 30,
                                    onPressed: (){
                                      authBloc.add(ClearLastNumberEvent(stateAuth.numbers.length));
                                    }, 
                                    icon: const Icon(FontAwesomeIcons.deleteLeft, color: Colors.grey)
                                  ),
                                )
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ]
                ),
                const SizedBox(height: 50),
                const TextCustom(
                  text: 'By deleting your account, all your information will be deleted',
                  textAlign: TextAlign.center,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}