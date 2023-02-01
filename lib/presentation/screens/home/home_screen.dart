import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/helpers/snack_messages.dart';
import 'package:safe_manager/presentation/screens/card/home_card_screen.dart';
import 'package:safe_manager/presentation/screens/home/app_password_screen.dart';
import 'package:safe_manager/presentation/screens/home/browser_password_screen.dart';
import 'package:safe_manager/presentation/screens/home/components/card_home_header.dart';
import 'package:safe_manager/presentation/screens/home/components/modal_bottom_type_password.dart';
import 'package:safe_manager/presentation/screens/home/components/modal_settings.dart';
import 'package:safe_manager/presentation/screens/home/components/recentrly_added.dart';
import 'package:safe_manager/presentation/screens/passwords/modal_add_password_home.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late HomeBloc homeBloc;

  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetPasswordAndStadisticHomeEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocListener(
      listeners: [
        BlocListener<PasswordBloc, PasswordState>(
          listener: (context, state) {
            if(state is SuccessCreatePasswordStatus){
              homeBloc.add(GetPasswordAndStadisticHomeEvent());
            }
            if(state is SuccessFailurePasswordStatus){
              snackMessageSuccess(context, 'Deleted');
            }
          },
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: TextCustom(
            text: 'Home',
            fontSize: 17,
            isTitle: true,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).primaryColor,
          ),
          centerTitle: true,
          leading: IconButton(
            splashRadius: 20,
            onPressed: (){
              modalSettings(context);
            }, 
            icon: const Icon(FontAwesomeIcons.barsStaggered, size: 19, color: Colors.grey)
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TextCustom(
                  text: 'Manage your',
                  color: Colors.grey,
                  isTitle: true,
                  fontSize: 15,
                ),
                TextCustom(
                  text: 'Password Easily',
                  isTitle: true,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 15.0),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (_, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CardHomeHeader(
                          title: 'Browser', 
                          subtitle: '${state.passwordBrowser.length} password',
                          icon: FontAwesomeIcons.earthAmericas,
                          color: const Color(0xffB288F7),
                          onTap: () async {
                            await Navigator.push(context, routeFade(page: const BrowserPasswordScreen()));
                            homeBloc.add(ClearSearchBrowserPasswordEvent());
                          },
                        ),
                        CardHomeHeader(
                          title: 'Apps', 
                          subtitle: '${state.passwordApp.length} password',
                          icon: FontAwesomeIcons.mobileScreen,
                          color: const Color(0xff2D9E2D),
                          onTap: () async {
                            await Navigator.push(context, routeFade(page: const AppPasswordScreen()));
                            homeBloc.add(ClearSearchAppPasswordEvent());
                          },
                        ),
                        CardHomeHeader(
                          title: 'Card', 
                          subtitle: '${state.cardStadistcs} cards',
                          icon: FontAwesomeIcons.creditCard,
                          color: const Color(0xff387EDD),
                          onTap: () {
                            Navigator.push(context, routeFade(page: const HomeCardScreen()));
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20.0),
                TextCustom(
                  text: 'Recently Added',
                  isTitle: true,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 20.0),
                const Expanded(
                  child: RecentrlyAdded()
                )
              ],
            ),
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'add-password',
              backgroundColor: ColorsFrave.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
              ),
              child: const Icon(FontAwesomeIcons.plus, color: Colors.white),
              onPressed: (){
                modalAddPasswordHome(context);
              }
            ),
            const SizedBox(height: 15.0),
            FloatingActionButton(
              heroTag: 'more-options',
              backgroundColor: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.purple,
                      ),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.orange,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      ),
                      CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.blue,
                      ),
                    ],
                  ),
                ],
              ),
              onPressed: (){
                modalBottomTypePassword(context);
              }
            ),
          ],
        ),
      ),
    );
  }
}