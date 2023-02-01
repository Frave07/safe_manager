import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:safe_manager/data/type_card/type_card_model.dart';
import 'package:safe_manager/domain/models/card_model/card_model.dart';
import 'package:uuid/uuid.dart';

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {


  CardBloc() : super(const CardState()) {

    on<SelectTypeCardEvent>(_selectTypeCard);
    on<SelectTypeCardModelEvent>(_selectTypeCardModel);
    on<SelectTypeColorEvent>(_selectTypeColor);
    on<ChangeCardNumberEvent>(_changeCardNumber);
    on<ChangeCardDateEvent>(_changeCardDate);
    on<ChangeCardCvvEvent>(_changeCardCvv);
    on<ClearChangeTypeCardEvent>(_clearChangeTypeCard);
    on<ClearAllCardEvent>(_clearAllCard);
    on<SaveNewCardEvent>(_saveNewCard);

  }


  Future<void> _selectTypeCard(SelectTypeCardEvent event, Emitter<CardState> emit) async {
  
    return emit(state.copyWith(typeCard: event.typecard));  
  }


  Future<void> _selectTypeCardModel(SelectTypeCardModelEvent event, Emitter<CardState> emit) async {
  
    return emit(state.copyWith(typeCardModel: event.typeCard));
  }


  Future<void> _selectTypeColor(SelectTypeColorEvent event, Emitter<CardState> emit) async {
  
    return emit(state.copyWith(typeCardColor: event.typeColor));
  }


  Future<void> _changeCardNumber(ChangeCardNumberEvent event, Emitter<CardState> emit) async {

    if(event.number.isEmpty){
      return emit(state.copyWith(cardNumber: 'XXXX XXXX XXXX XXXX'));
    }
  
    return emit(state.copyWith(cardNumber: event.number));
  }


  Future<void> _changeCardDate(ChangeCardDateEvent event, Emitter<CardState> emit) async {
  
    if(event.date.isEmpty){
      return emit(state.copyWith(cardDate: 'XX/XX'));
    }

    return emit(state.copyWith(cardDate: event.date));
  }


  Future<void> _changeCardCvv(ChangeCardCvvEvent event, Emitter<CardState> emit) async {
    
    if(event.cvv.isEmpty){
      return emit(state.copyWith(cardCvv: '****'));
    }
    return emit(state.copyWith(cardCvv: event.cvv));
  }


  Future<void> _clearChangeTypeCard(ClearChangeTypeCardEvent event, Emitter<CardState> emit) async {
    
    if(state.typeCardModel.uid == 3){
      return emit(state.copyWith(
        cardNumber: 'XXXX XXXXXX XXXXX',
        cardDate: 'XX/XX',
        cardCvv: '****'
      ));
    }

    if(state.typeCardModel.uid == 8){
      return emit(state.copyWith(
        cardNumber: 'XXXX XXXXXX XXXX',
        cardDate: 'XX/XX',
        cardCvv: '***'
      ));
    }

    return emit(state.copyWith(
      cardNumber: 'XXXX XXXX XXXX XXXX',
      cardDate: 'XX/XX',
      cardCvv: '***'
    ));
  
  }


  Future<void> _clearAllCard(ClearAllCardEvent event, Emitter<CardState> emit) async {
  
    return emit(const CardState());
  }


  Future<void> _saveNewCard(SaveNewCardEvent event, Emitter<CardState> emit) async {
  
    final box = Hive.box<CardModel>('encrypt-card-wallet-fraved');

    const uuid = Uuid();

    final newCard = CardModel(
      uid: uuid.v4(),
      numberCard: event.number,
      date: event.date,
      cvv: event.cvv,
      typeCard: event.typeCard,
      uidTypeCard: event.typemodel.uid,
      logo: event.typemodel.icon,
      nameTypeCard: event.typemodel.name,
      isFavorite: false,
      background: event.background,
      dateTime: DateTime.now()
    );

    box.add(newCard);

    return emit(SuccessCardState());
  }


}
