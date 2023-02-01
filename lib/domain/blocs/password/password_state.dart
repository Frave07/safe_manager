part of 'password_bloc.dart';

@immutable
class PasswordState extends Equatable {

  final int typePassword;
  final IconsLogo? iconLogo;

  const PasswordState({
    this.typePassword = 1,
    this.iconLogo
  });


  PasswordState copyWith({
    int? typePassword,
    IconsLogo? iconLogo,
  }) => PasswordState(
    typePassword: typePassword ?? this.typePassword,
    iconLogo: iconLogo,
  );
  
  @override
  List<Object?> get props => [
    typePassword,
    iconLogo,
  ];
}

class SuccessCreatePasswordStatus extends PasswordState {}

class SuccessFailurePasswordStatus extends PasswordState {}

