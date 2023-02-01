import 'package:hive/hive.dart';

part 'notes_model.g.dart';

@HiveType(typeId: 2)
class NotesModel {

  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final int uidColor;
  @HiveField(3)
  final int color;
  @HiveField(4)
  final String description;
  @HiveField(5)
  final DateTime date;
  @HiveField(6)
  final DateTime dateEdit;
  
  NotesModel({
    required this.uid, 
    required this.title, 
    required this.uidColor, 
    required this.color, 
    required this.description, 
    required this.date, 
    required this.dateEdit, 
  });

}