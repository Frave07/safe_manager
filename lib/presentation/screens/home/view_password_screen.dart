import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/domain/models/password_model.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/helpers/modal_clipboard.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class ViewPasswordScreen extends StatefulWidget {

  final PasswordModel password;
  final int index;

  const ViewPasswordScreen({Key? key, required this.password, required this.index}) : super(key: key);

  @override
  State<ViewPasswordScreen> createState() => _ViewPasswordScreenState();
}

class _ViewPasswordScreenState extends State<ViewPasswordScreen> {

  late TextEditingController _nicknameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _websiteController;
  late final PasswordBloc passwordBloc;
  late final HomeBloc homeBloc;

  @override
  void initState() {
    passwordBloc = BlocProvider.of<PasswordBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    _nicknameController = TextEditingController(text: widget.password.nickname);
    _emailController = TextEditingController(text: widget.password.email);
    _passwordController = TextEditingController(text: widget.password.password);
    _websiteController = TextEditingController(text: widget.password.website);
    super.initState();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _websiteController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextCustom(
          text: 'Vault',
          isTitle: true,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          splashRadius: 20,
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 19.0)
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(widget.password.pathLogo, height: 50),
                        const SizedBox(width: 10.0),
                        TextCustom(
                          text: widget.password.nickname,
                          isTitle: true,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: ColorsFrave.primary,
                        )
                      ],
                    ),
                    const SizedBox(height: 30.0),
                    const TextCustom(
                      text: 'Nickname',
                      isTitle: true,
                      fontWeight: FontWeight.w600,
                      color: ColorsFrave.primary,
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      controller: _nicknameController,
                      style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
                      cursorColor: ColorsFrave.primary,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Nickname',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey)
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const TextCustom(
                      text: 'Email',
                      isTitle: true,
                      fontWeight: FontWeight.w600,
                      color: ColorsFrave.primary,
                    ),
                    TextFormField(
                      controller: _emailController,
                      style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
                      cursorColor: ColorsFrave.primary,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Email',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey)
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const TextCustom(
                      text: 'Password',
                      isTitle: true,
                      fontWeight: FontWeight.w600,
                      color: ColorsFrave.primary,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      readOnly: true,
                      style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
                      cursorColor: ColorsFrave.primary,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter password or generate password',
                        hintStyle: GoogleFonts.poppins(color: Colors.grey),
                      ),
                    ),
                    if(widget.password.type == 1)...[
                      const SizedBox(height: 15.0),
                      TextCustom(
                        text: 'Website',
                        isTitle: true,
                        fontWeight: FontWeight.w600,
                        color: Colors.purple.shade600,
                      ),
                      TextFormField(
                        controller: _websiteController,
                        style: GoogleFonts.poppins(fontSize: 16.0, fontWeight: FontWeight.w600, color: ColorsFrave.primary),
                        cursorColor: ColorsFrave.primary,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter website',
                          hintStyle: GoogleFonts.poppins(color: Colors.grey)
                        ),
                      ),
                    ],
                    const SizedBox(height: 10.0),
                    const Divider(),
                    const SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                        modalClipBoard(context, 'Copied');
                        passwordBloc.add(CopyPasswordEvent(widget.password));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        width: double.infinity,
                        child: Row(
                          children: const [
                            Icon(FontAwesomeIcons.clone),
                            SizedBox(width: 10.0),
                            TextCustom(
                              text: 'Copy',
                              isTitle: true,
                              fontWeight: FontWeight.w600,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () {
                        passwordBloc.add(DeletePasswordEvent(widget.index));
                        Navigator.pop(context);
                        homeBloc.add(GetPasswordAndStadisticHomeEvent());
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        width: double.infinity,
                        child: Row(
                          children: [
                            Icon(FontAwesomeIcons.trashCan, color: Colors.red.shade600),
                            const SizedBox(width: 10.0),
                            TextCustom(
                              text: 'Delete',
                              isTitle: true,
                              fontWeight: FontWeight.w600,
                              color: Colors.red.shade600,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}