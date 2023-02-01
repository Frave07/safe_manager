import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safe_manager/data/type_card/type_card_model.dart';
import 'package:safe_manager/domain/blocs/blocs.dart';
import 'package:safe_manager/presentation/components/components.dart';
import 'package:safe_manager/presentation/helpers/formatter_card.dart';
import 'package:safe_manager/presentation/helpers/helpers.dart';
import 'package:safe_manager/presentation/helpers/snack_messages.dart';
import 'package:safe_manager/presentation/screens/card/components/card_options.dart';
import 'package:safe_manager/presentation/screens/card/components/design_card.dart';
import 'package:safe_manager/presentation/themes/themes.dart';
import 'package:safe_manager/presentation/utils/utils.dart';

class AddCardScreen extends StatefulWidget {

  const AddCardScreen({Key? key}) : super(key: key);

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {


  late final CardBloc cardBloc;
  late final HomeBloc homeBloc;
  late final TextEditingController _cardNumber;
  late final TextEditingController _cardDate;
  late final TextEditingController _cardCvv;
  String _emptyFields = '';

  @override
  void initState() {
    cardBloc = BlocProvider.of<CardBloc>(context);
    homeBloc = BlocProvider.of<HomeBloc>(context);
    _cardNumber = TextEditingController();
    _cardDate = TextEditingController();
    _cardCvv = TextEditingController();
    super.initState();
  }


  @override
  void dispose() {
    _cardNumber.dispose();
    _cardDate.dispose();
    _cardCvv.dispose();
    super.dispose();
  }

  
  @override
  Widget build(BuildContext context) {

    return BlocListener<CardBloc, CardState>(
      listener: (context, state) {
        if(state is SuccessCardState){
          _emptyFields = '';
          _cardCvv.clear();
          _cardDate.clear();
          _cardNumber.clear();
          cardBloc.add(ClearAllCardEvent());
          Navigator.pop(context);
          homeBloc.add(GetCardsHomeEvent());
          snackMessage(context, 'Card Added');
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
                cardBloc.add(ClearAllCardEvent());
              }, 
              icon: const Icon(FontAwesomeIcons.xmark, size: 22)
            )
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  
                  const DesignCard(),
                  const SizedBox(height: 20.0),
    
                  const TextCustom(
                    text: 'CARD OPTIONS',
                    isTitle: true,
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 10.0),
    
                  const CardOptions(),
                  const SizedBox(height: 25.0),
    
                  const TextCustom(
                    text: 'CARD DETAILS',
                    isTitle: true,
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 10.0),
    
                  BlocBuilder<CardBloc, CardState>(
                    buildWhen: (previous, current) {
                      if(previous.typeCardModel.uid != current.typeCardModel.uid){
                        _cardNumber.clear();
                        _cardDate.clear();
                        _cardCvv.clear();
                      }
                      return true;
                    },
                    builder: (_, state) {
                      return Container(
                        padding: const EdgeInsets.only(left: 20.0, top: 5.0, bottom: 5.0, right: 5.0),
                        height: 55,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: const Color(0xffF3F1ED)
                        ),
                        child: TextFormField(
                          controller: _cardNumber,
                          style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                          cursorColor: ColorsFrave.primary,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            MaskedTextInputFormatter(
                              mask: state.typeCardModel.uid == 3
                              ? 'XXXX XXXXXX XXXXX'
                              : state.typeCardModel.uid == 8
                                ? 'XXXX XXXXXX XXXX'
                                : 'XXXX XXXX XXXX XXXX',
                              separator: ' ',
                            ),
                            LengthLimitingTextInputFormatter(state.typeCardModel.uid == 3 
                              ? 17 
                              : state.typeCardModel.uid == 8 
                                ? 16
                                : 19
                            )
                          ],
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'XXXX XXXX XXXX XXXX'
                          ),
                          onChanged: (value) {
                            cardBloc.add(ChangeCardNumberEvent(value));
                          },
                        ),
                      );
                    },
                  ),
                  
                  const SizedBox(height: 15.0),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0, right: 5.0),
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color(0xffF3F1ED)
                          ),
                          child: TextFormField(
                            controller: _cardDate,
                            style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                            cursorColor: ColorsFrave.primary,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            inputFormatters: [
                              MaskedTextInputFormatter(
                                mask: 'XX/XX',
                                separator: '/',
                              ),
                              LengthLimitingTextInputFormatter(5)
                            ],
                            onChanged: (value) {
                              cardBloc.add(ChangeCardDateEvent(value));
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'XX/XX'
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15.0),
                      Flexible(
                        child: Container(
                          padding: const EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0, right: 5.0),
                          height: 55,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color(0xffF3F1ED)
                          ),
                          child: TextFormField(
                            controller: _cardCvv,
                            style: GoogleFonts.poppins(fontSize: 16, color: Colors.black),
                            cursorColor: ColorsFrave.primary,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4)
                            ],
                            onChanged: (value) {
                              cardBloc.add(ChangeCardCvvEvent(value));
                            },
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: '****'
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
    
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: TypeCardColor.typeCardColor.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, i) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              cardBloc.add(SelectTypeColorEvent(TypeCardColor.typeCardColor[i]));
                            },
                            child: BlocBuilder<CardBloc, CardState>(
                              builder: (_, state) {
                                return Container(
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    color: Color(TypeCardColor.typeCardColor[i].color),
                                    shape: BoxShape.circle
                                  ),
                                  child: TypeCardColor.typeCardColor[i].uid == state.typeCardColor.uid
                                    ? const Icon(FontAwesomeIcons.check, color: Colors.white, size: 20)
                                    : const SizedBox()
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<CardBloc, CardState>(
            builder: (_, state) {
              return BtnCustom(
                text: 'Save', 
                width: double.infinity,
                fontSize: 18,
                border: 50,
                fontWeight: FontWeight.bold,
                onTap: () {
                  
                  bool validateForm(){
                    _emptyFields = '';
                    if(_cardNumber.text.isEmpty) _emptyFields += '• Number is required\n';
                    if(_cardDate.text.isEmpty) _emptyFields += '• Date is required\n';
                    if(_cardCvv.text.isEmpty) _emptyFields += '• CVV is required\n';
                    if(state.typeCardModel.uid == 3 && _cardNumber.text.trim().length != 17) _emptyFields += '• Amex Card Number\n';
                    if(state.typeCardModel.uid == 8 && _cardNumber.text.trim().length != 16) _emptyFields += '• Diners Club Number\n';
                    if(_cardNumber.text.trim().isNotEmpty && state.typeCardModel.uid == 3 && _cardNumber.text.length != 17) _emptyFields += '• Card Number\n';
                    if(_cardNumber.text.trim().isNotEmpty && state.typeCardModel.uid == 8 && _cardNumber.text.length != 16) _emptyFields += '• Card Number\n';
                    if(_cardNumber.text.trim().isNotEmpty && state.typeCardModel.uid == 3 && _cardCvv.text.trim().length != 4) _emptyFields += '• Card CVV\n';
                    if(_cardNumber.text.trim().isNotEmpty && state.typeCardModel.uid == 8 && _cardCvv.text.trim().length != 3) _emptyFields += '• Card CVV\n';
                    if(_cardNumber.text.trim().isNotEmpty && state.typeCardModel.uid != 3 && _cardCvv.text.trim().length != 3) _emptyFields += '• Card CVV\n';
                    return isNullOrEmpty(_emptyFields);
                  }
    
                  if(validateForm()){
    
                    cardBloc.add(SaveNewCardEvent(
                      number: _cardNumber.text.trim(),
                      date: _cardDate.text.trim(),
                      cvv: _cardCvv.text.trim(),
                      background: state.typeCardColor.color,
                      typemodel: state.typeCardModel,
                      typeCard: state.typeCard
                    ));
    
                  }else{
                    modalMessage(context, '$_emptyFields\n');
                  }
    
                },
              );
            },
          ),
        ),
      ),
    );
  }
}