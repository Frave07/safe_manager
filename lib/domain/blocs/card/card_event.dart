part of 'card_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();

  @override
  List<Object> get props => [];
}

class SelectTypeCardEvent extends CardEvent {
  final String typecard;
  const SelectTypeCardEvent(this.typecard);
}

class SelectTypeCardModelEvent extends CardEvent {
  final TypeCardModel typeCard;
  const SelectTypeCardModelEvent(this.typeCard);
}

class SelectTypeColorEvent extends CardEvent {
  final TypeCardColor typeColor;
  const SelectTypeColorEvent(this.typeColor);
}

class ChangeCardNumberEvent extends CardEvent {
  final String number;
  const ChangeCardNumberEvent(this.number);
}

class ChangeCardDateEvent extends CardEvent {
  final String date;
  const ChangeCardDateEvent(this.date);
}

class ChangeCardCvvEvent extends CardEvent {
  final String cvv;
  const ChangeCardCvvEvent(this.cvv);
}

class ClearChangeTypeCardEvent extends CardEvent {}

class SaveNewCardEvent extends CardEvent {
  final String number;
  final String date;
  final String cvv;
  final int background;
  final String typeCard;
  final TypeCardModel typemodel;
  const SaveNewCardEvent({
    required this.number, 
    required this.date, 
    required this.cvv, 
    required this.background, 
    required this.typeCard, 
    required this.typemodel
  });
}

class ClearAllCardEvent extends CardEvent {}

