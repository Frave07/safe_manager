import 'package:hive_flutter/hive_flutter.dart';

part 'card_model.g.dart';

@HiveType(typeId: 1)
class CardModel {

  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String numberCard;
  @HiveField(2)
  final String date;
  @HiveField(3)
  final String cvv;
  @HiveField(4)
  final String typeCard;
  @HiveField(5)
  final int uidTypeCard;
  @HiveField(6)
  final String logo;
  @HiveField(7)
  final String nameTypeCard;
  @HiveField(8, defaultValue: false)
  final bool isFavorite;
  @HiveField(9)
  final int background;
  @HiveField(10)
  final DateTime dateTime;

  CardModel({
    required this.uid, 
    required this.numberCard, 
    required this.date, 
    required this.cvv, 
    required this.uidTypeCard, 
    required this.typeCard, 
    required this.logo, 
    required this.nameTypeCard, 
    this.isFavorite = false, 
    required this.background, 
    required this.dateTime, 
  });

}