import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/security/components/card_item_security.dart';
import 'package:safe_manager/presentation/screens/security/verify_pin_screen.dart';

class HomeSecurityScreen extends StatelessWidget {

  const HomeSecurityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final securityBloc = BlocProvider.of<SecurityBloc>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const TextCustom(
          text: 'Security',
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CardItemSecurity(
                    title: 'Change PIN',
                    prefixWidget: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.blueGrey),
                    icon: FontAwesomeIcons.key,
                    onTap: () async {
                      await Navigator.push(context, routeFade(page: const VerifyPinScreen()));
                      securityBloc.add(ClearAllPinEvent());
                    },
                  ),
                  const CardItemSecurity(
                    title: 'Enabled Biometric',
                    prefixWidget: AnimatedToggle(
                      isActive: false
                    ),
                    icon: FontAwesomeIcons.fingerprint,
                  ),
                  const CardItemSecurity(
                    title: 'Enable Screenshots',
                    prefixWidget: AnimatedToggle(
                      isActive: false
                    ),
                    icon: FontAwesomeIcons.mobileScreen
                  ),
                  // CardItemSecurity(
                  //   title: 'Download Backup',
                  //   prefixWidget: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.blueGrey),
                  //   icon: FontAwesomeIcons.fileExport,
                  //   onTap: () {
                      
                  //   },
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}