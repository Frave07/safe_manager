part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable {

  final bool existAccount;
  final List<int> numbers;
  final bool isFailPassword;
  final bool isSuccessPassword;

  const AuthState({
    this.existAccount = false,
    this.numbers = const [],
    this.isFailPassword = false,
    this.isSuccessPassword = false,
  });


  AuthState copyWith({
    bool? existAccount,
    List<int>? numbers,
    bool? isFailPassword,
    bool? isSuccessPassword,
  }) => AuthState(
    existAccount: existAccount ?? this.existAccount,
    numbers: numbers ?? this.numbers,
    isFailPassword: isFailPassword ?? this.isFailPassword,
    isSuccessPassword: isSuccessPassword ?? this.isSuccessPassword,
  );

  
  @override
  List<Object> get props => [
    existAccount,
    numbers,
    isFailPassword,
    isSuccessPassword,
  ];
  
}

