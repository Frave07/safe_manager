import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/about/home_about_screen.dart';
import 'package:safe_manager/presentation/screens/initial/initial_screen.dart';
import 'package:safe_manager/presentation/screens/security/home_security_screen.dart';
import 'package:safe_manager/presentation/themes/themes.dart';
import 'package:url_launcher/url_launcher.dart';

import 'animated_toggle_theme.dart';
import 'item_modal_setting.dart';

void modalSettings(BuildContext context){

  final themesBloc = BlocProvider.of<ThemesBloc>(context);
  final authBloc = BlocProvider.of<AuthBloc>(context);
  final size = MediaQuery.of(context).size;

  showGeneralDialog(
    context: context,
    barrierColor: Colors.black54, 
    transitionDuration: const Duration(milliseconds: 200),
    transitionBuilder: (context, animation, _, child) {
      return ScaleTransition(
        scale: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
        child: AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 15.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          content: SizedBox(
            width: size.width,
            height: size.height * .85,
            child: SingleChildScrollView(
              child: ListBody(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextCustom(
                        text: 'Settings', 
                        fontWeight: FontWeight.w600, 
                        color: Theme.of(context).primaryColor,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        }, 
                        child: const Icon(FontAwesomeIcons.xmark, color: Colors.grey)
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 5.0),
                  const TextCustom(
                    text: 'Dark mode',
                    color: ColorsFrave.subtitle,
                    fontSize: 15,
                  ),
                  const SizedBox(height: 10.0),
                  BlocBuilder<ThemesBloc, ThemesState>(
                    builder: (_, state) {
                      return AnimatedToggleTheme(
                        onChanged: () {
                          themesBloc.add(ChangeThemeToOscureEvent(!state.isOscure));
                        },
                      );
                    }
                  ),
                  const SizedBox(height: 15.0),
                  const TextCustom(
                    text: 'General',
                    color: ColorsFrave.subtitle,
                    fontSize: 15,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Column(
                      children: [
                        ItemModalSetting(
                          text: 'Security',
                          icon: FontAwesomeIcons.lock,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, routeFade(page: const HomeSecurityScreen()));
                          },
                        ),
                        const Divider(),
                        ItemModalSetting(
                          text: 'About',
                          icon: FontAwesomeIcons.faceSmile,
                          onTap: () {
                            Navigator.pop(context);
                            Navigator.push(context, routeFade(page: const HomeAboutScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const TextCustom(
                    text: 'Support',
                    color: ColorsFrave.subtitle,
                    fontSize: 15,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Column(
                      children: [
                        ItemModalSetting(
                          text: 'Contact me',
                          icon: FontAwesomeIcons.envelope,
                          onTap: () {
                            Navigator.pop(context);
                            launchUrl(Uri.parse('https://www.instagram.com/frave_developer'), mode: LaunchMode.externalApplication);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  const TextCustom(
                    text: 'More',
                    color: Color(0xff7e8896),
                    fontSize: 15,
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    child: Column(
                      children: [
                        ItemModalSetting(
                          text: 'Privacy policy',
                          icon: FontAwesomeIcons.shield,
                          onTap: () {
                            
                          },
                        ),
                        const Divider(),
                        ItemModalSetting(
                          text: 'Terms of services',
                          icon: FontAwesomeIcons.bookmark,
                          onTap: () {
                            
                          },
                        ),
                        const Divider(),
                        ItemModalSetting(
                          text: 'App version',
                          icon: FontAwesomeIcons.info,
                          onTap: () {},
                          isVersion: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      authBloc.add(VerifyAccountEvent());
                      Navigator.pushAndRemoveUntil(context, routeFade(page: const InitialScreen()), (_) => false);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color,
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(FontAwesomeIcons.arrowRightFromBracket, color: ColorsFrave.redLogOut, size: 20),
                          SizedBox(width: 10.0),
                          TextCustom(
                            text: 'Log out',
                            isTitle: true,
                            fontWeight: FontWeight.w600,
                            color: ColorsFrave.redLogOut,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    pageBuilder: (_, __, ___) => const SizedBox(),
  );
}