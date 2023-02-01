part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class VerifyAccountEvent extends AuthEvent {}

class SelectNumberEvent extends AuthEvent {
  final int number;
  const SelectNumberEvent(this.number);
}

class ClearLastNumberEvent extends AuthEvent {
  final int index;
  const ClearLastNumberEvent(this.index);
}

class ClearAllNumbersEvent extends AuthEvent {}

class VerifyPasswordEvent extends AuthEvent {}

class VerifyAccountForDeleteEvent extends AuthEvent {}

class ClearAllEvent extends AuthEvent {}

