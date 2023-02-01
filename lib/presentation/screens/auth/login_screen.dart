import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/home/home_screen.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if(state.numbers.length == 6){
          Future.delayed(const Duration(milliseconds: 350)).then((_) {
            authBloc.add(VerifyPasswordEvent());
          });
        }
        if(state.isSuccessPassword){
          authBloc.add(ClearAllNumbersEvent());
          Navigator.pushAndRemoveUntil(context, routeFade(page: const HomeScreen()), (_) => false);
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
                    text: 'Enter your password',
                    fontSize: 21,
                    isTitle: true,
                    color: ColorsFrave.primary,
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
                const SizedBox(height: 80)
              ],
            ),
          ),
        ),
      ),
    );
  }
}