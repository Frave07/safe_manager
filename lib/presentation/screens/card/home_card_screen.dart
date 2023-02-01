import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/screens/card/add_card_screen.dart';
import 'package:safe_manager/presentation/screens/card/components/cards_home.dart';
import 'package:safe_manager/presentation/themes/themes.dart';

class HomeCardScreen extends StatefulWidget {

  const HomeCardScreen({Key? key}) : super(key: key);

  @override
  State<HomeCardScreen> createState() => _HomeCardScreenState();
}

class _HomeCardScreenState extends State<HomeCardScreen> {


  late final HomeBloc homeBloc;


  @override
  void initState() {
    homeBloc = BlocProvider.of<HomeBloc>(context);
    homeBloc.add(GetCardsHomeEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const TextCustom(
          text: 'My Cards',
          isTitle: true,
          fontWeight: FontWeight.w600, 
          fontSize: 19,
        ),
        centerTitle: true,
        leading: IconButton(
          splashRadius: 20,
          onPressed: (){
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.close)
        ),
        actions: [
          IconButton(
            splashRadius: 20,
            onPressed: (){
              Navigator.push(context, routeFade(page: const AddCardScreen()));
            }, 
            icon: const Icon(FontAwesomeIcons.plus, size: 19)
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: size.height,
              width: size.width,
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    ColorsFrave.primary,
                    Colors.white,
                  ]
                )
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 10,
              child: Container(
                height: 150,
                width: 150,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.green,
                      Colors.white,
                      Colors.white,
                    ]
                  )
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              right: 10,
              child: Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      ColorsFrave.redLogOut,
                      Colors.white,
                      Colors.white,
                    ]
                  )
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.2)),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 10,
              child: Container(
                height: 40,
                width: 150,
                color: Colors.blue.shade50,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              left: 10,
              child: Container(
                height: 40,
                width: 150,
                color: Colors.blue.shade50,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
                  ),
                ),
              ),
            ),
            BlocBuilder<HomeBloc, HomeState>(
              builder: (_, state) {
                return Swiper(
                  itemCount: state.cards.length,
                  itemHeight: 230,
                  itemWidth: size.width * .95,
                  itemBuilder: (BuildContext context,int i){
                    return CardsHome(
                      background: state.cards[i].background, 
                      typeCard: state.cards[i].typeCard, 
                      number: state.cards[i].numberCard, 
                      date: state.cards[i].date, 
                      cvv: state.cards[i].cvv, 
                      uidType: state.cards[i].uidTypeCard, 
                      logo: state.cards[i].logo
                    );
                  },
                  // scrollDirection: Axis.vertical,
                  layout: SwiperLayout.CUSTOM,
                  customLayoutOption: CustomLayoutOption(
                    startIndex: -1,
                    stateCount: 3
                  )..addRotate([
                    -45.0/180,
                    0.0,
                    45.0/180
                  ])..addTranslate([
                    const Offset(-470.0, -40.0),
                    const Offset(0.0, 0.0),
                    const Offset(470.0, -70.0)
                  ]),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}