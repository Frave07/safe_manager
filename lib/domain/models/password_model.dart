import 'package:hive/hive.dart';

part 'password_model.g.dart';

@HiveType(typeId: 0)
class PasswordModel {

  @HiveField(0)
  final String uid;
  @HiveField(1)
  final String nickname;
  @HiveField(2)
  final int type;
  @HiveField(3)
  final String pathLogo;
  @HiveField(4, defaultValue: '')
  final String email;
  @HiveField(5)
  final String password;
  @HiveField(6, defaultValue: '')
  final String website;
  @HiveField(7)
  final DateTime date;
  @HiveField(8, defaultValue: false)
  final bool isFavorite;
  

  PasswordModel({
    required this.uid, 
    required this.nickname, 
    required this.type, 
    required this.pathLogo, 
    this.email = '', 
    required this.password,
    this.website = '',
    required this.date,
    required this.isFavorite,
  });

}