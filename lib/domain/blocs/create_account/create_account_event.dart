part of 'create_account_bloc.dart';

abstract class CreateAccountEvent extends Equatable {
  const CreateAccountEvent();

  @override
  List<Object> get props => [];
}

class SelectNumberByCreateAccountEvent extends CreateAccountEvent {
  final int number;
  const SelectNumberByCreateAccountEvent(this.number);
}

class ClearLastNumberByCreateAccountEvent extends CreateAccountEvent {
  final int index;
  const ClearLastNumberByCreateAccountEvent(this.index);
}

class ResetValuesCreateAccountEvent extends CreateAccountEvent {}

class SelectNumberRepeatByCreateAccountEvent extends CreateAccountEvent {
  final int number;
  const SelectNumberRepeatByCreateAccountEvent(this.number);
}

class ClearLastNumberRepeatByCreateAccountEvent extends CreateAccountEvent {
  final int index;
  const ClearLastNumberRepeatByCreateAccountEvent(this.index);
}

class ClearNumberRepeatByCreateAccountEvent extends CreateAccountEvent {}

class VerifyPasswordsByCreateAccountEvent extends CreateAccountEvent {}


