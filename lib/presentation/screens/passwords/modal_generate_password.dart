import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/helpers/modal_clipboard.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

void modalGeneratePassword(BuildContext context) {

  final TextEditingController passwordController = TextEditingController();
  final generatePasswordBloc = BlocProvider.of<GeneratePasswordBloc>(context);

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
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0)
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextCustom(
                        text: 'Generate password',
                        isTitle: true,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(FontAwesomeIcons.xmark)
                      )
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
                    builder: (_, state) {
                      passwordController.text = state.password;
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60),
                        decoration: BoxDecoration(
                          color: ColorsFrave.primary.withOpacity(.03),
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: ColorsFrave.primary.withOpacity(.5)),
                        ),
                        child: TextFormField(
                          readOnly: true,
                          controller: passwordController,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorsFrave.primary),
                          cursorColor: ColorsFrave.primary,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'password',
                            hintStyle: GoogleFonts.poppins(color: Colors.grey)
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24.0),
                  const TextCustom(
                    text: 'LENGTH',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10.0),
                  BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade100,
                            child: const TextCustom(
                              text: '0',
                              isTitle: true,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Expanded(
                            child: Slider(
                              value: state.length.toDouble(), 
                              min: 0,
                              max: 40,
                              label: '${state.length}',
                              activeColor: ColorsFrave.primary,
                              inactiveColor: Colors.grey,
                              onChanged: (value) {
                                generatePasswordBloc.add(LengthPasswordEvent(value));
                              },
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.grey.shade100,
                            child: TextCustom(
                              text: '${state.length}',
                              isTitle: true,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      );
                    }
                  ),

                  const SizedBox(height: 30.0),
                  const TextCustom(
                    text: 'SETTINGS ',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(
                          text: 'Uppercase letters'
                        ),
                        BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
                          builder: (_, state) {
                            return GestureDetector(
                              onTap: () => generatePasswordBloc.add(GeneratePasswordUppercaseEvent(!state.uppercase)),
                              child: AnimatedToggle(
                                isActive: state.uppercase
                              ),
                            );
                          }
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(
                          text: 'Lowercase letters'
                        ),
                        BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
                          builder: (_, state) {
                            return GestureDetector(
                              onTap: () => generatePasswordBloc.add(GeneratePasswordLowercaseEvent(!state.lowercase)),
                              child: AnimatedToggle(
                                isActive: state.lowercase
                              ),
                            );
                          }
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(
                          text: 'Numbers'
                        ),
                        BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
                          builder: (_, state) {
                            return GestureDetector(
                              onTap: () => generatePasswordBloc.add(GeneratePasswordNumbersEvent(!state.numbers)),
                              child: AnimatedToggle(
                                isActive: state.numbers
                              ),
                            );
                          }
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextCustom(
                          text: 'Special symbols'
                        ),
                        BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
                          builder: (_, state) {
                            return GestureDetector(
                              onTap: (){
                                if(state.uppercase || state.lowercase || state.numbers){
                                  generatePasswordBloc.add(GeneratePasswordSpecialEvent(!state.specialCharacters));
                                }
                              },
                              child: AnimatedToggle(
                                isActive: state.specialCharacters
                              ),
                            );
                          }
                        )
                      ],
                    ),
                  ),
                  
                ],
              ),
              
              const SizedBox(height: 24.0),
              Row(
                children: [
                  Expanded(
                    child: BtnCustom(
                      text: 'COPY', 
                      border: 50,
                      fontWeight: FontWeight.bold,
                      isTitle: true,
                      width: double.infinity,
                      onTap:() {
                        modalClipBoard(context, 'Copied');
                        generatePasswordBloc.add(CopyPasswordGenerateEvent(passwordController.text.trim()));
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  GestureDetector(
                    onTap: () {
                      generatePasswordBloc.add(RefreshPasswordEvent());
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: ColorsFrave.primary.withOpacity(.2)
                      ),
                      child: const Icon(FontAwesomeIcons.rotate, color: Colors.black87),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );


}