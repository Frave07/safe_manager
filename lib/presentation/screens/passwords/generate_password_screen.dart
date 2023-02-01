import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/helpers/modal_clipboard.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class GeneratePasswordScreen extends StatefulWidget {

  const GeneratePasswordScreen({Key? key}) : super(key: key);

  @override
  State<GeneratePasswordScreen> createState() => _GeneratePasswordScreenState();
}

class _GeneratePasswordScreenState extends State<GeneratePasswordScreen> {

  late final TextEditingController _passwordController;
  late final GeneratePasswordBloc _generatePasswordBloc;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _generatePasswordBloc = BlocProvider.of<GeneratePasswordBloc>(context);
    _generatePasswordBloc.add(GeneratePasswordFirstEvent());
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextCustom(
          text: 'Generate Password',
          isTitle: true,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22)
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TextCustom(
                text: 'GENERATED PASSWORD',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
              const SizedBox(height: 5.0),
              BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(
                builder: (_, state) {
                  _passwordController.text = state.password;
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 60),
                    decoration: BoxDecoration(
                      color: ColorsFrave.primary.withOpacity(.03),
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: ColorsFrave.primary.withOpacity(.5)),
                    ),
                    child: TextFormField(
                      readOnly: true,
                      controller: _passwordController,
                      style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorsFrave.primary),
                      textAlign: TextAlign.center,
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
              const SizedBox(height: 20.0),
              const TextCustom(
                text: 'LENGTH: ',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Colors.grey,
              ),
              const SizedBox(height: 5.0),
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
                            _generatePasswordBloc.add(LengthPasswordEvent(value));
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
                text: 'SETTINGS: ',
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
                          onTap: () => _generatePasswordBloc.add(GeneratePasswordUppercaseEvent(!state.uppercase)),
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
                          onTap: () => _generatePasswordBloc.add(GeneratePasswordLowercaseEvent(!state.lowercase)),
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
                          onTap: () => _generatePasswordBloc.add(GeneratePasswordNumbersEvent(!state.numbers)),
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
                              _generatePasswordBloc.add(GeneratePasswordSpecialEvent(!state.specialCharacters));
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
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
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
                  _generatePasswordBloc.add(CopyPasswordGenerateEvent(_passwordController.text.trim()));
                },
              ),
            ),
            const SizedBox(width: 10.0),
            GestureDetector(
              onTap: () {
                _generatePasswordBloc.add(RefreshPasswordEvent());
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
        ),
      ),
    );
  }
}