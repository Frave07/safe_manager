import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/create/verify_password_create_account_screen.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class CreateAccountScreen extends StatelessWidget {

  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final createAccountBloc = BlocProvider.of<CreateAccountBloc>(context);

    return  BlocListener<CreateAccountBloc, CreateAccountState>(
      listener: (context, state) async {
        if(state.numbersCreate.length == 6){
          await Future.delayed(const Duration(milliseconds: 350)).then((_){
            Navigator.pushReplacement(context, routeFade(page: const VerifyPasswordCreateAccountScreen()));
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              splashRadius: 20,
              onPressed: (){
                Navigator.pop(context);
                createAccountBloc.add(ResetValuesCreateAccountEvent());
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
                    text: 'Enter a new password',
                    fontSize: 21,
                    isTitle: true,
                    color: ColorsFrave.primary,
                    fontWeight: FontWeight.w500,
                  )
                ),
                Column(
                  children: [
                    const SizedBox(height: 40.0),
                    BlocBuilder<CreateAccountBloc, CreateAccountState>(
                      builder: (_, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(6, (i) 
                            => Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Icon(
                                state.numbersCreate.length >= i + 1
                                ? FontAwesomeIcons.solidCircle
                                : FontAwesomeIcons.circle, 
                                color: state.numbersCreate.length >= i + 1
                                ? ColorsFrave.primary
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
                                    createAccountBloc.add(SelectNumberByCreateAccountEvent(state.listNumberByCreate[0]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[1]}',
                                  onTap: () {
                                    createAccountBloc.add(SelectNumberByCreateAccountEvent(state.listNumberByCreate[1]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[2]}',
                                  onTap: () {
                                    createAccountBloc.add(SelectNumberByCreateAccountEvent(state.listNumberByCreate[2]));
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
                                    createAccountBloc.add(SelectNumberByCreateAccountEvent(state.listNumberByCreate[3]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[4]}',
                                  onTap: () {
                                    createAccountBloc.add(SelectNumberByCreateAccountEvent(state.listNumberByCreate[4]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[5]}',
                                  onTap: () {
                                    createAccountBloc.add(SelectNumberByCreateAccountEvent(state.listNumberByCreate[5]));
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
                                    createAccountBloc.add(SelectNumberByCreateAccountEvent(state.listNumberByCreate[6]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[7]}',
                                  onTap: () {
                                    createAccountBloc.add(SelectNumberByCreateAccountEvent(state.listNumberByCreate[7]));
                                  },
                                ),
                                NumberOption(
                                  text: '${state.listNumberByCreate[8]}',
                                  onTap: () {
                                    createAccountBloc.add(SelectNumberByCreateAccountEvent(state.listNumberByCreate[8]));
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
                                    createAccountBloc.add(SelectNumberByCreateAccountEvent(state.listNumberByCreate[9]));
                                  },
                                ),
                                const SizedBox(width: 20.0),
                                BlocBuilder<CreateAccountBloc, CreateAccountState>(
                                  builder: (_, stateAccount) 
                                  => IconButton(
                                    splashRadius: 30,
                                    onPressed: (){
                                      createAccountBloc.add(ClearLastNumberByCreateAccountEvent(stateAccount.numbersCreate.length));
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
                const SizedBox(height: 80.0)
              ],
            ),
          ),
        ),
      ),
    );
  }
}