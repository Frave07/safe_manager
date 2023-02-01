part of 'generate_password_bloc.dart';

@immutable
class GeneratePasswordState extends Equatable {

  final String password;
  final bool uppercase;
  final bool lowercase;
  final bool numbers;
  final bool specialCharacters;
  final int length;

  const GeneratePasswordState({
    this.password = '',
    this.uppercase = true,
    this.lowercase = true,
    this.numbers = true,
    this.specialCharacters = true,
    this.length = 8,
  });


  GeneratePasswordState copyWith({
    String? password,
    bool? uppercase,
    bool? lowercase,
    bool? numbers,
    bool? specialCharacters,
    int? length,
  }) => GeneratePasswordState(
    password: password ?? this.password,
    uppercase: uppercase ?? this.uppercase,
    lowercase: lowercase ?? this.lowercase,
    numbers: numbers ?? this.numbers,
    specialCharacters: specialCharacters ?? this.specialCharacters,
    length: length ?? this.length,
  );
  

  @override
  List<Object> get props => [
    password,
    uppercase,
    lowercase,
    numbers,
    specialCharacters,
    length,
  ];

}

