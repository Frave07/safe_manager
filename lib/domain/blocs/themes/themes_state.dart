part of 'themes_bloc.dart';

@immutable
class ThemesState extends Equatable {

  final bool isOscure;

  const ThemesState({
    this.isOscure = false,
  });


  ThemesState copyWith({
    bool? isOscure,
  }) => ThemesState(
    isOscure: isOscure ?? this.isOscure,
  );
  

  @override
  List<Object> get props => [
    isOscure,
  ];

}
