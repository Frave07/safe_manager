import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/helpers/helpers.dart';
import 'package:safe_manager/presentation/screens/passwords/components/type_password.dart';
import 'package:safe_manager/presentation/screens/passwords/modal_choose_icon.dart';
import 'package:safe_manager/presentation/screens/passwords/modal_generate_password.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

void modalAddPasswordHome(BuildContext context) {

  final generatePasswordBloc = BlocProvider.of<GeneratePasswordBloc>(context);
  final passwordBloc = BlocProvider.of<PasswordBloc>(context);
  final homeBloc = BlocProvider.of<HomeBloc>(context);
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();

  showModalBottomSheet(
    context: context, 
    barrierColor: Colors.black54,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    builder: (context) => FractionallySizedBox(
      heightFactor: .97,
      child: Container(
        height: MediaQuery.of(context).size.height,
        margin: const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextCustom(
                    text: 'Add password',
                    isTitle: true,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                  BlocBuilder<PasswordBloc, PasswordState>(
                    builder: (context, state) {
                      return TextButton(
                        child: const TextCustom(
                          text: 'Done',
                          isTitle: true,
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                        ),
                        onPressed: () {
                          if(nicknameController.text.trim().isEmpty || emailController.text.trim().isEmpty || passwordController.text.trim().isEmpty){
                            return modalMessage(context, 'Some fileds are required');
                          }
                    
                          passwordBloc.add(SavePasswordEvent(
                            nickname: nicknameController.text.trim(),
                            type: state.typePassword,
                            logo: state.iconLogo != null ? state.iconLogo!.path : 'assets/logos/default.svg',
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                            website: websiteController.text.trim(),
                          ));

                          Navigator.pop(context);

                          passwordController.clear();
                          nicknameController.clear();
                          emailController.clear();
                          websiteController.clear();

                          homeBloc.add(GetPasswordAndStadisticHomeEvent());
                        },
                      );
                    }
                  ),
                ],
              ),
              const Divider(height: 1),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: nicknameController,
                style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorsFrave.primary),
                cursorColor: ColorsFrave.primary,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Nickname',
                  hintStyle: GoogleFonts.poppins(color: ColorsFrave.subtitle)
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                children: [
                  const TypePassword(),
                  const SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: (){
                      modalChooseIconLogo(context);
                    },
                    child: BlocBuilder<PasswordBloc, PasswordState>(
                      builder: (context, state) {
                        if(state.iconLogo == null){
                          return Container(
                            width: 140,
                            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.blue.shade50,
                              border: Border.all(color: Colors.blue)
                            ),
                            child: Row(
                              children: const [
                                Icon(FontAwesomeIcons.plus, color: Colors.grey, size: 17),
                                SizedBox(width: 5.0),
                                TextCustom(
                                  text: 'Choose icon',
                                  isTitle: true,
                                  color: Colors.blueGrey,
                                  fontSize: 14,
                                )
                              ],
                            ),
                          );
                        }
                        return SvgPicture.asset(state.iconLogo!.path, height: 35, width: 35);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              TextFormField(
                controller: emailController,
                style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorsFrave.primary),
                cursorColor: ColorsFrave.primary,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter Email',
                  hintStyle: GoogleFonts.poppins(color: ColorsFrave.subtitle)
                ),
              ),
              const SizedBox(height: 24.0),
              BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
                builder: (_, state) {
                  passwordController.text = state.password;
                  return TextFormField(
                    controller: passwordController,
                    style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorsFrave.primary),
                    cursorColor: ColorsFrave.primary,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter password or generate password',
                      hintStyle: GoogleFonts.poppins(color: ColorsFrave.subtitle)
                    ),
                  );
                },
              ),
              const SizedBox(height: 24.0),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      generatePasswordBloc.add(GeneratePasswordFirstEvent());
                    },
                    child: Container(
                      width: 185,
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.green.shade50,
                        border: Border.all(color: Colors.green)
                      ),
                      child: Row(
                        children: const [
                          Icon(FontAwesomeIcons.key, color: Colors.grey, size: 16),
                          SizedBox(width: 5.0),
                          TextCustom(
                            text: 'Generate password',
                            isTitle: true,
                            color: Colors.blueGrey,
                            fontSize: 14,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      generatePasswordBloc.add(GeneratePasswordFirstEvent());
                      modalGeneratePassword(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Colors.blue.shade50,
                        border: Border.all(color: Colors.blue)
                      ),
                      child: Row(
                        children: const [
                          Icon(FontAwesomeIcons.key, color: Colors.grey, size: 16),
                          SizedBox(width: 5.0),
                          TextCustom(
                            text: 'Custom',
                            isTitle: true,
                            color: Colors.blueGrey,
                            fontSize: 14,
                          )
                        ],
                      ),
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(height: 24.0),
              BlocBuilder<PasswordBloc, PasswordState>(
                builder: (_, state) {
                  if(state.typePassword == 1){
                    return TextFormField(
                      controller: websiteController,
                      style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorsFrave.primary),
                      cursorColor: ColorsFrave.primary,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter website',
                        hintStyle: GoogleFonts.poppins(color: ColorsFrave.subtitle)
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    ),
  ).then((_){
    nicknameController.clear();
    emailController.clear();
    passwordController.clear();
    websiteController.clear();
    passwordBloc.add(ClearIconPasswordEvent());
  });


}