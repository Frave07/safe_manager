part of 'generate_password_bloc.dart';

abstract class GeneratePasswordEvent extends Equatable {
  const GeneratePasswordEvent();

  @override
  List<Object> get props => [];
}

class GeneratePasswordFirstEvent extends GeneratePasswordEvent {}

class GeneratePasswordUppercaseEvent extends GeneratePasswordEvent {
  final bool isuppercase;
  const GeneratePasswordUppercaseEvent(this.isuppercase);
}

class GeneratePasswordLowercaseEvent extends GeneratePasswordEvent {
  final bool isLowercase;
  const GeneratePasswordLowercaseEvent(this.isLowercase);
}

class GeneratePasswordNumbersEvent extends GeneratePasswordEvent {
  final bool isNumbers;
  const GeneratePasswordNumbersEvent(this.isNumbers);
}

class GeneratePasswordSpecialEvent extends GeneratePasswordEvent {
  final bool isSpecial;
  const GeneratePasswordSpecialEvent(this.isSpecial);
}

class LengthPasswordEvent extends GeneratePasswordEvent {
  final double length;
  const LengthPasswordEvent(this.length);
}

class RefreshPasswordEvent extends GeneratePasswordEvent {}

class CopyPasswordGenerateEvent extends GeneratePasswordEvent {
  final String password;
  const CopyPasswordGenerateEvent(this.password);
}
