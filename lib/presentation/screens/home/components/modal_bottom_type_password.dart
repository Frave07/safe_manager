import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/presentation/components/animation_route.dart';
import 'package:safe_manager/presentation/screens/card/add_card_screen.dart';
import 'package:safe_manager/presentation/screens/home/components/item_option_type.dart';
import 'package:safe_manager/presentation/screens/notepad/notepad_home_screen.dart';
import 'package:safe_manager/presentation/screens/passwords/modal_add_password_home.dart';

void modalBottomTypePassword(BuildContext context) {

  showModalBottomSheet(
    context: context, 
    barrierColor: Colors.black54,
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
    builder: (context) => Container(
      height: 230,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      color: Colors.transparent,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white70
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(16.0)
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
              child: Column(
                children: [                  
                  ItemOptionType(
                    onTap: () {
                      Navigator.pop(context);
                      modalAddPasswordHome(context);
                    },
                    icon: const Icon(FontAwesomeIcons.key, size: 17, color: Colors.purple),
                    title: 'New Password',
                  ),
                  const Divider(height: 1),
                  ItemOptionType(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, routeFade(page: const AddCardScreen()));
                    },
                    icon: const Icon(FontAwesomeIcons.creditCard, size: 17, color: Colors.orange),
                    title: 'New Card',
                  ),
                  const Divider(height: 1),
                  ItemOptionType(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(context, routeFade(page: const NotepadHomeScreen()));
                    },
                    icon: const Icon(FontAwesomeIcons.fileLines, size: 17, color: Colors.green),
                    title: 'Notepad',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );


}