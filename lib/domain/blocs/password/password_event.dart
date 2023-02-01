part of 'password_bloc.dart';

abstract class PasswordEvent extends Equatable {
  const PasswordEvent();

  @override
  List<Object> get props => [];
}

class SelectTypePasswordEvent extends PasswordEvent {
  final int type;
  const SelectTypePasswordEvent(this.type);
}

class SelectIconLogoPasswordEvent extends PasswordEvent {
  final IconsLogo logo;
  const SelectIconLogoPasswordEvent(this.logo);
}

class ClearIconPasswordEvent extends PasswordEvent {}

class SavePasswordEvent extends PasswordEvent {
  final String nickname;
  final int type;
  final String logo;
  final String email;
  final String password;
  final String? website;

  const SavePasswordEvent({
    required this.nickname, 
    required this.type, 
    required this.logo, 
    required this.email, 
    required this.password, 
    this.website
  });
}

class CopyPasswordEvent extends PasswordEvent {
  final PasswordModel password;
  const CopyPasswordEvent(this.password);
}

class DeletePasswordEvent extends PasswordEvent {
  final int index;
  const DeletePasswordEvent(this.index);
}

