part of 'card_bloc.dart';

@immutable
class CardState extends Equatable {

  final String typeCard;
  final TypeCardModel typeCardModel;
  final TypeCardColor typeCardColor;
  final String cardNumber;
  final String cardDate;
  final String cardCvv;

  const CardState({
    this.typeCard = 'Credit',
    this.typeCardModel =  const TypeCardModel(uid: 1, name: 'Visa', icon: 'assets/logos/visa.svg'),
    this.typeCardColor = const TypeCardColor(uid: 9, color: 0xDD000000),
    this.cardNumber = 'XXXX XXXX XXXX XXXX',
    this.cardDate = 'XX/XX',
    this.cardCvv = '****',
  });


  CardState copyWith({
    String? typeCard,
    TypeCardModel? typeCardModel,
    TypeCardColor? typeCardColor,
    String? cardNumber,
    String? cardDate,
    String? cardCvv,
  }) => CardState(
    typeCard: typeCard ?? this.typeCard,
    typeCardModel: typeCardModel ?? this.typeCardModel,
    typeCardColor: typeCardColor ?? this.typeCardColor,
    cardNumber: cardNumber ?? this.cardNumber,
    cardDate: cardDate ?? this.cardDate,
    cardCvv: cardCvv ?? this.cardCvv,
  );

  
  @override
  List<Object> get props => [
    typeCard,
    typeCardModel,
    typeCardColor,
    cardNumber,
    cardDate,
    cardCvv,
  ];

}


class SuccessCardState extends CardState {}

