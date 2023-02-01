part of 'home_bloc.dart';

@immutable
class HomeState extends Equatable {

  final List<PasswordModel> passwordRecently;
  final List<PasswordModel> passwordBrowser;
  final List<PasswordModel> passwordApp;
  final List<PasswordModel> searchPasswordApp;
  final List<PasswordModel> searchPasswordBrowers;
  final List<CardModel> cards;
  final int cardStadistcs;

  const HomeState({
    this.passwordRecently = const [],
    this.passwordBrowser = const [],
    this.passwordApp = const [],
    this.searchPasswordApp = const [],
    this.searchPasswordBrowers = const [],
    this.cards = const [],
    this.cardStadistcs = 0,
  });


  HomeState copyWith({
    List<PasswordModel>? passwordRecently,
    List<PasswordModel>? passwordBrowser,
    List<PasswordModel>? passwordApp,
    List<PasswordModel>? searchPasswordApp,
    List<PasswordModel>? searchPasswordBrowers,
    List<CardModel>? cards,
    int? cardStadistcs,
  }) => HomeState(
    passwordRecently: passwordRecently ?? this.passwordRecently,
    passwordBrowser: passwordBrowser ?? this.passwordBrowser,
    passwordApp: passwordApp ?? this.passwordApp,
    searchPasswordApp: searchPasswordApp ?? this.searchPasswordApp,
    searchPasswordBrowers: searchPasswordBrowers ?? this.searchPasswordBrowers,
    cards: cards ?? this.cards,
    cardStadistcs: cardStadistcs ?? this.cardStadistcs,
  );

  
  @override
  List<Object> get props => [
    passwordRecently,
    passwordBrowser,
    passwordApp,
    searchPasswordApp,
    searchPasswordBrowers,
    cards,
    cardStadistcs,
  ];

}
