part of 'create_account_bloc.dart';

@immutable
class CreateAccountState extends Equatable {

  final List<int> numbersCreate;
  final List<int> verifyNumbersCreate;
  final bool isFailurePassword;
  final bool isSuccessCreateAccount;

  const CreateAccountState({
    this.numbersCreate = const [],
    this.verifyNumbersCreate = const [],
    this.isFailurePassword = false,
    this.isSuccessCreateAccount = false,
  });
  

  CreateAccountState copyWith({
    List<int>? numbersCreate, 
    List<int>? verifyNumbersCreate, 
    bool? isFailurePassword,
    bool? isSuccessCreateAccount,
  }) => CreateAccountState(
    numbersCreate: numbersCreate ?? this.numbersCreate,
    verifyNumbersCreate: verifyNumbersCreate ?? this.verifyNumbersCreate,
    isFailurePassword: isFailurePassword ?? this.isFailurePassword,
    isSuccessCreateAccount: isSuccessCreateAccount ?? this.isSuccessCreateAccount,
  );


  @override
  List<Object> get props => [
    numbersCreate,
    verifyNumbersCreate,
    isFailurePassword,
    isSuccessCreateAccount,
  ];

}

