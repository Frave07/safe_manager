part of 'security_bloc.dart';

@immutable
class SecurityState extends Equatable {

  final List<int> numbers;
  final List<int> newNumbers;
  final bool isSuccessPassword;
  final bool isFailurePassword;
  final bool successNewPassword;

  const SecurityState({
    this.numbers = const [],
    this.newNumbers = const [],
    this.isSuccessPassword = false,
    this.isFailurePassword = false,
    this.successNewPassword = false,
  });


  SecurityState copyWith({
    List<int>? numbers,
    List<int>? newNumbers,
    bool? isSuccessPassword,
    bool? isFailurePassword,
    bool? successNewPassword,
  }) => SecurityState(
    numbers: numbers ?? this.numbers,
    newNumbers: newNumbers ?? this.newNumbers,
    isSuccessPassword: isSuccessPassword ?? this.isSuccessPassword,
    isFailurePassword: isFailurePassword ?? this.isFailurePassword,
    successNewPassword: successNewPassword ?? this.successNewPassword,
  );

  
  @override
  List<Object> get props => [
    numbers,
    newNumbers,
    isSuccessPassword,
    isFailurePassword,
    successNewPassword,
  ];

}
