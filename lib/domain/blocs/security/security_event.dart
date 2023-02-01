part of 'security_bloc.dart';

abstract class SecurityEvent extends Equatable {
  const SecurityEvent();

  @override
  List<Object> get props => [];
}

class SelectNumberVerifyPinEvent extends SecurityEvent {
  final int number;
  const SelectNumberVerifyPinEvent(this.number);
}

class SelectNumberNewPinEvent extends SecurityEvent {
  final int number;
  const SelectNumberNewPinEvent(this.number);
}

class ClearLastNumberVerifyPinEvent extends SecurityEvent {
  final int index;
  const ClearLastNumberVerifyPinEvent(this.index);
}

class ClearLastNumberNewPinEvent extends SecurityEvent {
  final int index;
  const ClearLastNumberNewPinEvent(this.index);
}

class VerifyPinEvent extends SecurityEvent {}

class SaveNewPinEvent extends SecurityEvent {}

class ClearAllPinEvent extends SecurityEvent {}

